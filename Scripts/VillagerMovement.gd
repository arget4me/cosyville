extends CharacterBody2D
class_name VillagerClass

@export var speed = 100
var destination: Vector2
var goto_pos: Vector2 = Vector2(-1,-1)
var is_on_dest = false
var max_speed = speed * 2
var speed_increase = 1
var speed_increase_time = 5
var speed_increase_counter = 0

@onready var anim = $AnimationPlayer


signal death

var is_dead = false

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
	if global_position.distance_to(destination) > 5.0:
		var direction = (destination - position).normalized()
		velocity = direction * speed
		is_on_dest = false
	
	if(is_on_dest):
		goto_pos = Vector2(-1,-1)

func set_destination(position: Vector2):
	goto_pos = position

func _physics_process(delta):
	if is_dead:
		return
	#get_input()

	if(goto_pos == Vector2(-1,-1)):
		return
	action_do_move(goto_pos)
	move_and_slide()
	
	speed_increase_counter += delta
	if(speed_increase_counter > speed_increase_time):
		speed_increase_counter = 0
		var random_int = randi_range(1,40)
		if(random_int == 5):
			speed = 300
		if(random_int == 6):
			speed = 50
		if(speed < max_speed):
			speed += speed_increase
	
func kill_villager():
	is_dead = true
	anim.play("Death")
	
	death.emit()
	
	var timer := Timer.new()
	timer.one_shot = true
	timer.wait_time = anim.current_animation_length
	timer.timeout.connect(queue_free)
	
func _on_villager_brain_on_new_action_started(action_name: String) -> void:
	if is_dead:
		return
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
	
	
