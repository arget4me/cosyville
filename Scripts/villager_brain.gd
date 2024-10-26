extends Node

@export var villager: VillagerClass
var is_doing_action = false
var curr_plan = []
var last_action
var timeout_timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass 

func action_move_to():
	is_doing_action = true
	var exit = false
	var dest = ActionPointsManager.get_random_action_point_position()
	villager.set_destination(dest)
	
	while(!exit):
		await get_tree().create_timer(0.2).timeout
		if(villager.is_on_dest):
			exit = true

	# add score for the action we completed
	ClickingManager.add_score(GoapManager.action_name_to_score[curr_plan[0]])
	curr_plan.remove_at(0)
	is_doing_action = false
	
func action_chop_wood():
	is_doing_action = true
	
	await get_tree().create_timer(2).timeout
	
	ClickingManager.add_score(GoapManager.action_name_to_score[curr_plan[0]])
	curr_plan.remove_at(0)
	is_doing_action = false
	
func action_fish():
	is_doing_action = true
	
	await get_tree().create_timer(3).timeout
	
	ClickingManager.add_score(GoapManager.action_name_to_score[curr_plan[0]])
	curr_plan.remove_at(0)
	is_doing_action = false

func do_some_action():
	var action = curr_plan[0]
	match(action):
		"DO_ACTION":
			action_chop_wood()
		"DO_FISHING":
			action_fish()
		"GO_TO_POS":
			action_move_to()


func _process(delta: float) -> void:
	if(curr_plan.size()<=0 && !is_doing_action):
		var action_random = randf_range(0, 0.5)
		if(action_random <= 0.5):
			# chop wood
			curr_plan = GoapManager.request_plan("do_action", [])
		else:
			curr_plan = GoapManager.request_plan("do_fishing", [])
	if(!is_doing_action && curr_plan.size() > 0):
		do_some_action()
	
