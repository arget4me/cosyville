extends Node

var action_points_wood = []
var action_points_fish = []
var action_points_house = []

enum action_point_type {WOOD, FISH, HOUSE}

func _ready() -> void:
	GameManager.on_game_state_changed.connect(on_state_changed)
	pass # Replace with function body.

func _process(delta: float) -> void:
	pass

func on_state_changed(state: GameManager.game_state):
	if(state == GameManager.game_state.START):
		action_points_wood.clear()
		action_points_fish.clear()
		action_points_house.clear()
	pass

func get_random_action_point_position(type: action_point_type) -> Vector2:
	var action_points = get_action_points(type)
	if(action_points.size() <= 0):
		return Vector2(-1,-1)

	return action_points.pick_random()
	
func register_action_point(position: Vector2, type: action_point_type):
	append_action_point(position, type)
	pass
	
func get_action_points(type: action_point_type) -> Array:
	match type:
		action_point_type.WOOD:
			return action_points_wood
		action_point_type.FISH:
			return action_points_fish
		action_point_type.HOUSE:
			return action_points_house
	return action_points_wood
	
	
func append_action_point(point: Vector2, type: action_point_type):
	match type:
		action_point_type.WOOD:
			action_points_wood.append(point)
		action_point_type.FISH:
			action_points_fish.append(point)
		action_point_type.HOUSE:
			action_points_house.append(point)
