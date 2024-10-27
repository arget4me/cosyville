extends CharacterBody2D

@export var speed = 60
@export var waypoint_nodes: Array[Node2D] 

var current_waypoint_index = 0 

func _ready() -> void:
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
	var clamped_wp = clampi(current_waypoint_index - 2, 0, waypoint_nodes.size())
	current_waypoint_index -= clamped_wp # back it up a bit
