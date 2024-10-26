extends Node

signal on_score_update(score : int)

var score = 0
var score_per_second = 100
var timer : Timer

func _ready():
	timer = Timer.new()
	timer.wait_time = 1.0
	timer.one_shot = false
	timer.timeout.connect(add_score_per_second)
	add_child(timer)
	GameManager.on_game_state_changed.connect(_reset_score)

func _reset_score(state : GameManager.game_state):
	if state == GameManager.game_state.PLAYING:
		timer.start()
		score = 0
		on_score_update.emit(score)
	else:
		timer.stop()

func add_score_per_second():
	add_score(score_per_second)

func add_score(amount : int):
	score += amount
	on_score_update.emit(score)
