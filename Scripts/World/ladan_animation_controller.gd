extends Node2D

@onready var animtree = $AnimationTree
@onready var score_animation = preload("res://Scenes/UI/score_animation.tscn")
var state_machine

func _ready() -> void:
	state_machine = animtree["parameters/playback"]

func _on_clickable_on_display_clickable() -> void:
	state_machine.travel("Click")
	var new_score_animation = score_animation.instantiate()
	new_score_animation.position.y -= 100
	add_child(new_score_animation)
