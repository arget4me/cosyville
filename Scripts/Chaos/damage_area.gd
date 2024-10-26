extends Area2D

@export var damage_area_active := false

func _on_body_entered(body: Node2D) -> void:
	if damage_area_active:
		if body is VillagerClass:
			body.kill_villager()
