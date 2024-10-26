extends Node

enum game_state {START, PLAYING, PAUSE, GAME_OVER, VICTORY}
var current_state = game_state.START
signal on_game_state_changed(state : game_state)

func transition_to_state(state: game_state) -> void:
	if(current_state == state):
		return
	if(!check_transitioning_rules(current_state, state)):
		return
	print("GameManager: Transitioning states: " + game_state.keys()[current_state] + "-->" + game_state.keys()[state])
	current_state = state
	on_game_state_changed.emit(current_state)

func check_transitioning_rules(from_state: game_state, to_state: game_state) -> bool:
	match from_state:
		game_state.START:
			if(to_state == game_state.PLAYING):
				return true
		game_state.PLAYING:
			if(to_state == game_state.PAUSE || to_state == game_state.VICTORY || to_state == game_state.GAME_OVER):
				return true
		game_state.PAUSE:
			if(to_state == game_state.PLAYING):
				return true
		game_state.GAME_OVER:
			if(to_state == game_state.START):
				return true
		game_state.VICTORY:
			if(to_state == game_state.START):
				return true	
	return false
	pass
