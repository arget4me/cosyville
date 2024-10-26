extends Node2D

@onready var sprite = $Sprite2D
@onready var clickable = $Clickable
@onready var chaos = $ChaosTriggerable
@onready var damage_area = $DamageArea
@onready var fire_node = $FireNode

@export var fire_color := Color.WHITE 

func _ready():
	clickable.set_process(false)
	ActionPointsManager.register_action_point(position)
	fire_node.visible = false

func _on_node_trigger_chaos() -> void:
	sprite.self_modulate = fire_color
	clickable.clicking_is_enabled = true
	damage_area.damage_area_active = true
	fire_node.visible = true

func _on_clickable_on_clicked() -> void:
	clickable.clicking_is_enabled = false
	damage_area.damage_area_active = false
	fire_node.visible = false
	chaos.deactivate_chaos()
	sprite.self_modulate = Color.WHITE
