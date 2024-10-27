extends CharacterBody2D

@export var speed = 60
@export var waypoint_nodes: Array[Node2D] 

@onready var animtree = $"../AnimationTree"

var current_waypoint_index = 0 
var state_machine

func _ready() -> void:
	state_machine = animtree["parameters/playback"]
	if waypoint_nodes.size() == 0:
		print("No waypoint nodes assigned!")
	else:
		print("Starting movement between waypoint nodes.")

func _physics_process(delta: float) -> void:
	if waypoint_nodes.size() > 0:
		var target_position = waypoint_nodes[current_waypoint_index].global_position
		
		if global_position.distance_to(target_position) > 5:
			var direction = (target_position - global_position).normalized()
			velocity = direction * speed
		else:
			current_waypoint_index = (current_waypoint_index + 1) % waypoint_nodes.size()
		move_and_slide()
	else:
		velocity = Vector2.ZERO


func _on_clickable_on_clicked() -> void:
	state_machine.travel("Angry")
	var random_wp = randi_range(0, waypoint_nodes.size() - 1)
	current_waypoint_index = random_wp
