extends Node

var action_points = []

func _ready() -> void:
	GameManager.on_game_state_changed.connect(on_state_changed)
	pass # Replace with function body.

func _process(delta: float) -> void:
	pass

func on_state_changed(state: GameManager.game_state):
	if(state == GameManager.game_state.START):
		action_points.clear()
	pass

func get_random_action_point_position() -> Vector2:
	if(action_points.size() <= 0):
		return Vector2(-1,-1)

	return action_points.pick_random()
	
func register_action_point(position: Vector2):
	action_points.append(position)
	pass
	
func unregister_action_point(position: Vector2):
	var i = 0
	for point in action_points:
		if(point == position):
			break
		i += 1
	action_points.remove_at(i)
