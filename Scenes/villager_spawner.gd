extends Node2D

@onready var villager_scene = preload("res://Scenes/villager_instance.tscn")
signal villager_spawned
# Called when the node enters the scene tree for the first time.
func _ready():
	villager_spawned.connect(VillagerManager._on_villager_spawned)
	for i in range(20):
		spawn_villager(Vector2(350 + i, 850))

func spawn_villager(position: Vector2):
	var new_villager: VillagerClass = villager_scene.instantiate()
	new_villager.position = position
	new_villager.death.connect(VillagerManager._on_villager_death)
	villager_spawned.emit()
	add_child(new_villager)
