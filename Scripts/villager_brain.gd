extends Node

@export var villager: VillagerClass
var is_doing_action = false
var curr_plan = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func action_move_to():
	is_doing_action = true
	var exit = false
	var dest = ActionPointsManager.get_random_action_point_position()
	villager.set_destination(dest)
	
	while(!exit):
		await get_tree().create_timer(0.2).timeout
		if(villager.is_on_dest):
			exit = true
	
	curr_plan.remove_at(0)
	is_doing_action = false
	
func action_chop_wood():
	is_doing_action = true
	
	await get_tree().create_timer(2).timeout
			
	curr_plan.remove_at(0)
	is_doing_action = false

func do_some_action():
	var action = curr_plan[0]
	match(action):
		"DO_ACTION":
			action_chop_wood()
		"GO_TO_POS":
			action_move_to()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(curr_plan.size()<=0 && !is_doing_action):
		curr_plan = GoapManager.request_plan("do_action", [])
	if(!is_doing_action && curr_plan.size() > 0):
		do_some_action()
	
