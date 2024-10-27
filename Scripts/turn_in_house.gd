extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var offset_position = global_position
	offset_position.y += 10
	ActionPointsManager.register_action_point(offset_position, ActionPointsManager.action_point_type.HOUSE)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
