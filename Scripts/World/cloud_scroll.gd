extends Node2D


@export var speed : float = 10
@export var length : float = 300

var original_x

func _ready():
	original_x = global_position.x

func _process(delta):
	global_position += Vector2.RIGHT * delta * speed
	
	if global_position.x - original_x >= length:
		global_position.x -= length
