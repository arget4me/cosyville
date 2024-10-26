extends Node2D

@onready var sprite = $Sprite2D
@onready var clickable = $Clickable
@onready var chaos = $ChaosTriggerable
@onready var damage_area = $DamageArea

func _ready():
	clickable.set_process(false)

func _on_node_trigger_chaos() -> void:
	sprite.self_modulate = Color.RED
	clickable.clicking_is_enabled = true
	damage_area.damage_area_active = true

func _on_clickable_on_clicked() -> void:
	clickable.clicking_is_enabled = false
	damage_area.damage_area_active = false
	chaos.deactivate_chaos()
	sprite.self_modulate = Color.WHITE
