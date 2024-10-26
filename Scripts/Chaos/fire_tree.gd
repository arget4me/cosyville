extends Node2D

@onready var sprite = $Sprite2D
@onready var clickable = $Clickable
@onready var chaos = $ChaosTriggerable

func _ready():
	clickable.set_process(false)

func _on_node_trigger_chaos() -> void:
	sprite.self_modulate = Color.RED
	clickable.clicking_is_enabled = true

func _on_clickable_on_clicked() -> void:
	clickable.clicking_is_enabled = false
	chaos.deactivate_chaos()
	sprite.self_modulate = Color.WHITE
