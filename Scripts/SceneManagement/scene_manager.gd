extends Node

@export var ui_base_node: Node
@export var game_world_base_node: Node

#references to our scenes so we can keep track of em
var start_ui
var playing_ui
var playing_hud
var playing_game_world

func _ready() -> void:
	start_ui = preload("res://Scenes/UI/start_ui.tscn").instantiate()
	ui_base_node.add_child(start_ui)
	GameManager.on_game_state_changed.connect(_game_state_changed)

#do scene spawning and despawning in the UI and world nodes
func _game_state_changed(state: GameManager.game_state) -> void:
	match state:
		GameManager.game_state.PLAYING:
			start_ui.queue_free()
			playing_ui = preload("res://Scenes/UI/playing_ui.tscn").instantiate()
			playing_game_world = preload("res://Scenes/World/Village.tscn").instantiate()
			ui_base_node.add_child(playing_ui)
			game_world_base_node.add_child(playing_game_world)
			pass
		GameManager.game_state.START:
			playing_ui.queue_free()
			playing_game_world.queue_free()
			start_ui = preload("res://Scenes/UI/start_ui.tscn").instantiate()
			ui_base_node.add_child(start_ui)
	pass
