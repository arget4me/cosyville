extends CharacterBody2D
class_name VillagerClass

@export var speed = 100
var destination: Vector2 = Vector2 (-1,-1)

signal death

func _ready() -> void:
	InputMap.load_from_project_settings()

func get_input():
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_direction * speed
	if(Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)):
		#print(get_global_mouse_position())
		destination = get_global_mouse_position()
	elif(velocity == Vector2.ZERO && destination == Vector2.ZERO):
		destination = Vector2.ZERO
		print("returning")
		return;

	if global_position.distance_to(destination) > 1.0:
		var direction = (destination - position).normalized()
		velocity = direction * speed

func action_do_move(destination: Vector2):
	if global_position.distance_to(destination) > 1.0:
		var direction = (destination - position).normalized()
		velocity = direction * speed

func _physics_process(delta):
	get_input()
	#if(destination == Vector2(-1,-1)):
	#	destination = ActionPointsManager.get_random_action_point_position()
	#	if(destination == Vector2(-1,-1)):
	#		return
	#action_do_move(destination)
	# print(velocity)
	move_and_slide()
	
func kill_villager():
	death.emit()
	queue_free()
