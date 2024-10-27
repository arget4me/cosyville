extends Node2D

@onready var animtree = $AnimationTree
var state_machine

func _ready() -> void:
	state_machine = animtree["parameters/playback"]

func _on_clickable_on_display_clickable() -> void:
	state_machine.travel("Click")
