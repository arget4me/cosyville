extends Button

@export var goto_state_on_click = GameManager.game_state.START

func _ready() -> void:
	self.pressed.connect(button_clicked)

func button_clicked():
	GameManager.transition_to_state(goto_state_on_click)

func quit_game():
	get_tree().quit()

func _on_goto_state_button_2_pressed() -> void:
	quit_game()
