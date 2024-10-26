extends Node

var actions = {}
var action_name_to_index = {}

func _ready() -> void:
	actions["GO_TO_POS"] = goap_action.new(["at_pos"],[])
	actions["DO_ACTION"] = goap_action.new(["do_action"],["at_pos"])
	action_name_to_index["GO_TO_POS"] = 0
	action_name_to_index["DO_ACTION"] = 1

func request_plan(goal, world_state: Array) -> Array:
	#setup nodes for astar
	var astar = goap_astar.new()
	for key in actions:
		var action = actions[key]
		var i = action_name_to_index[key]
		var size = action.requirements.size()
		if(size > 0):
			astar.add_point(i,Vector2(i,0), size)
		else:
			astar.add_point(i,Vector2(i,0))

	for key in actions:
		var action = actions[key]
		var i = action_name_to_index[key]
		for req in action.requirements:
			for key2 in actions:
				var j = action_name_to_index[key2]
				if(key == key2):
					continue
				var action2 = actions[key2]
				if(action2.satisfies.has(req)):
					astar.connect_points(i, j, false)
					
	#find out starting node based on world states
	var start_action
	var goal_action
	for key in actions:
		var action = actions[key]
		if(action.satisfies.has(goal)):
			goal_action = key
			break
	if(world_state.size() == 0): #special case if no world state is satisfied yet
		for key in actions:
			var action = actions[key]
			if(action.requirements.size() == 0):
				start_action = key
	#else:
	#	for key in actions:
	#		var action = actions[key]
	#		if(action.satisfies.has(goal)):
	
	var planned_path = astar.get_id_path(action_name_to_index[goal_action], action_name_to_index[start_action])
	var actions_plan = []
	for id in planned_path:
		var index = 0
		for key in actions:
			if(index == id):
				actions_plan.append(key)
	print(actions_plan)
	return[]
