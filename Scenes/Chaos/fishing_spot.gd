extends Node2D

@onready var sprite = $Sprite2D
@onready var clickable = $Clickable


func _ready():
	clickable.set_process(false)
	ActionPointsManager.register_action_point(position, ActionPointsManager.action_point_type.FISH)

func _on_clickable_on_clicked() -> void:
	clickable.clicking_is_enabled = false
	sprite.self_modulate = Color.WHITE
