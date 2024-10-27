extends Node

@export var ui_base_node: Node
@export var game_world_base_node: Node

#references to our scenes so we can keep track of em
var start_ui
var playing_hud
var playing_game_world
var game_over_world

func _ready() -> void:
	start_ui = preload("res://Scenes/UI/start_ui.tscn").instantiate()
	ui_base_node.add_child(start_ui)
	GameManager.on_game_state_changed.connect(_game_state_changed)

func destroy_playing_hud():
	playing_hud.queue_free()

#do scene spawning and despawning in the UI and world nodes
func _game_state_changed(state: GameManager.game_state) -> void:
	match state:
		GameManager.game_state.PLAYING:
			start_ui.queue_free()
			playing_hud = preload("res://Scenes/UI/hud.tscn").instantiate()
			playing_game_world = preload("res://Scenes/World/Village.tscn").instantiate()
			ui_base_node.add_child(playing_hud)
			game_world_base_node.add_child(playing_game_world)
			pass
		GameManager.game_state.START:
			game_over_world.queue_free()
			start_ui = preload("res://Scenes/UI/start_ui.tscn").instantiate()
			ui_base_node.add_child(start_ui)
		GameManager.game_state.GAME_OVER:
			destroy_playing_hud()
			playing_game_world.queue_free()
			game_over_world = preload("res://Scenes/game_over.tscn").instantiate()
			game_world_base_node.add_child(game_over_world)
			pass
	pass
