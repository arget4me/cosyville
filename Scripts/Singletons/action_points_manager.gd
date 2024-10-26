extends Node

var action_points = []
var action_points_status = []

func _ready() -> void:
	GameManager.on_game_state_changed.connect(on_state_changed)
	pass # Replace with function body.

func _process(delta: float) -> void:
	pass

func on_state_changed(state: GameManager.game_state):
	if(state == GameManager.game_state.START):
		action_points.clear()
		action_points_status.clear()
	pass

func get_random_action_point_position() -> Vector2:
	if(action_points.size() <= 0):
		return Vector2(-1,-1)
	var rng = RandomNumberGenerator.new()
	var random_index = rng.randi_range(0,action_points.size()-1)
	return action_points[random_index]
	
func register_action_point(position: Vector2):
	action_points.append(position)
	action_points_status.append(false)
	pass
	
func unregister_action_point(position: Vector2):
	var i = 0
	for point in action_points:
		if(point == position):
			break
		i += 1
	action_points.remove_at(i)
	action_points_status.remove_at(i)
