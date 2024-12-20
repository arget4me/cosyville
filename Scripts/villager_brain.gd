extends Node

@export var villager: VillagerClass
@onready var score_animation = preload("res://Scenes/UI/score_animation.tscn")
var is_doing_action = false
var curr_plan = []
var prev_action = ""
var current_action = ""
signal on_new_action_started(action_name: String)

var timeout_timer

var prev_position
var check_stuck_time = 5
var stuck_time_counter = 0
var plan_failed = false
var current_resource_type: ActionPointsManager.action_point_type

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	prev_position = villager.global_position
	pass 

func action_move_to():
	is_doing_action = true
	var plan_index = curr_plan.size() - 1

	var exit = false
	var dest = ActionPointsManager.get_random_action_point_position(current_resource_type)
	villager.set_destination(dest)
	
	while(!exit && !plan_failed):
		await get_tree().create_timer(0.2).timeout
		if(villager.is_on_dest):
			exit = true
	
	curr_plan.remove_at(plan_index)
	is_doing_action = false
	
func action_chop_wood():
	SoundManager.play_sfx('chop')
	is_doing_action = true
	var plan_index = curr_plan.size() - 1
	if(!plan_failed):
		await get_tree().create_timer(2).timeout
	
	curr_plan.remove_at(plan_index)
	is_doing_action = false
	
func action_fish():
	is_doing_action = true
	var plan_index = curr_plan.size() - 1
	if(!plan_failed):
		await get_tree().create_timer(3).timeout
	curr_plan.remove_at(plan_index)
	is_doing_action = false
	
func action_hand_in_fish():
	is_doing_action = true
	var plan_index = curr_plan.size() - 1

	var exit = false
	var dest = ActionPointsManager.get_random_action_point_position(ActionPointsManager.action_point_type.HOUSE)
	villager.set_destination(dest)
	
	while(!exit && !plan_failed):
		await get_tree().create_timer(0.2).timeout
		if(villager.is_on_dest):
			exit = true
	
	if(!plan_failed):
		add_score(GoapManager.action_name_to_score[curr_plan[plan_index]])

	curr_plan.remove_at(plan_index)
	is_doing_action = false

func action_hand_in_wood():
	is_doing_action = true
	var plan_index = curr_plan.size() - 1

	var exit = false
	var dest = ActionPointsManager.get_random_action_point_position(ActionPointsManager.action_point_type.HOUSE)
	villager.set_destination(dest)
	
	while(!exit && !plan_failed):
		await get_tree().create_timer(0.2).timeout
		if villager.global_position.distance_to(dest) < 20.0:
			exit = true
			
	if(!plan_failed):
		add_score(GoapManager.action_name_to_score[curr_plan[plan_index]])
	
	curr_plan.remove_at(plan_index)
	is_doing_action = false

func do_some_action():
	var plan_index = curr_plan.size() - 1
	var action = curr_plan[plan_index]
	match(action):
		"DO_ACTION":
			action_chop_wood()
		"DO_FISHING":
			action_fish()
		"GO_TO_POS":
			action_move_to()
		"DO_HAND_IN_FISH":
			action_hand_in_fish()
		"DO_HAND_IN_WOOD":
			action_hand_in_wood()

func add_score(score: int):
	ClickingManager.add_score(score)
	var new_animation = score_animation.instantiate()
	new_animation.position = villager.position
	add_child(new_animation)
	
	var random_death_chance = randf_range(0, 100)
	if(random_death_chance < 5):
		print("Random death of villager!")
		villager.kill_villager()
	
func _process(delta: float) -> void:
	if(curr_plan.size()<=0 && !is_doing_action):
		plan_failed = false
		var action_random = randf_range(0, 0.7)
		if(action_random <= 0.5):
			# chop wood
			curr_plan = GoapManager.request_plan("do_hand_in_wood", [])
		else:
			curr_plan = GoapManager.request_plan("do_hand_in_fish", [])
		if(curr_plan.has("DO_ACTION")):
			current_resource_type = ActionPointsManager.action_point_type.WOOD
		if(curr_plan.has("DO_FISHING")):
			current_resource_type = ActionPointsManager.action_point_type.FISH
	if(!is_doing_action && curr_plan.size() > 0):
		do_some_action()
	
	stuck_time_counter += delta
	if(stuck_time_counter > check_stuck_time):
		stuck_time_counter = 0
		if(villager.global_position.distance_to(prev_position) < 10.0):
			plan_failed = true
		prev_position = villager.global_position
	
	if(curr_plan.size()>0):
		current_action = curr_plan[curr_plan.size()-1]
		if(current_action != prev_action):
			on_new_action_started.emit(current_action)
			prev_action = current_action
		
	
