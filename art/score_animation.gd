extends Node2D

@onready var animation_player = $AnimationPlayer
var is_deleting = false

func _ready():
	animation_player.play('up_and_fade_away')

func _on_animation_player_animation_finished(anim_name):
	queue_free()
