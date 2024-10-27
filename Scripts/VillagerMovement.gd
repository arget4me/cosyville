extends CharacterBody2D
class_name VillagerClass

@export var speed = 100
var destination: Vector2
var goto_pos: Vector2 = Vector2(-1,-1)
var is_on_dest = false

@onready var anim = $AnimationPlayer


signal death

func _ready() -> void:
	InputMap.load_from_project_settings()
	anim.play("Walk")

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
	is_on_dest = true
	if global_position.distance_to(destination) > 1.0:
		var direction = (destination - position).normalized()
		velocity = direction * speed
		is_on_dest = false
	
	if(is_on_dest):
		goto_pos = Vector2(-1,-1)

func set_destination(position: Vector2):
	goto_pos = position

func _physics_process(delta):
	#get_input()

	if(goto_pos == Vector2(-1,-1)):
		return
	action_do_move(goto_pos)
	move_and_slide()
	
func kill_villager():
	death.emit()
	queue_free()


func _on_villager_brain_on_new_action_started(action_name: String) -> void:
	match(action_name):
		"GO_TO_POS":
			anim.play("Walk")
		"DO_ACTION":
			anim.play("Chop_Wood")
		"DO_FISHING":
			anim.play("Do_Fishing")
		"DO_HAND_IN_FISH":
			anim.play("Walk_Fish")
		"DO_HAND_IN_WOOD":
			anim.play("Walk_Wood")
	
	
