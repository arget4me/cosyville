extends Node

var wait_for_duration = 5
var wait_counter = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	wait_counter += delta
	if(wait_counter > wait_for_duration):
		GameManager.transition_to_state(GameManager.game_state.START)
	pass
