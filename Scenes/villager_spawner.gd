extends Node2D

@onready var villager_scene = preload("res://Scenes/villager_instance.tscn")
signal villager_spawned

var spawn_more_at = 1000
var prev_thousands = 0 
var is_spawning = false

var x = 700
var y = 550
# Called when the node enters the scene tree for the first time.
func _ready():
	ClickingManager.on_score_update.connect(_on_score_updated)
	villager_spawned.connect(VillagerManager._on_villager_spawned)
	for i in range(20):
		spawn_villager(Vector2(x, y))
		await get_tree().create_timer(0.2).timeout

func spawn_villager(position: Vector2):
	var new_villager: VillagerClass = villager_scene.instantiate()
	new_villager.position = position
	new_villager.death.connect(VillagerManager._on_villager_death)
	villager_spawned.emit()
	add_child(new_villager)
	
func _on_score_updated(score: int):
	var reminder = score % spawn_more_at
	var thousands = (score - reminder)/spawn_more_at
	if(thousands != prev_thousands && !is_spawning):
		is_spawning = true
		for i in range(5):
			spawn_villager(Vector2(x, y))
			await get_tree().create_timer(0.2).timeout
		is_spawning = false
	prev_thousands = thousands
	pass
