extends Node

signal on_score_update(score : int)

var score = 0
var score_per_second = 100

func _ready():
	var timer := Timer.new()
	timer.wait_time = 1.0
	timer.one_shot = false
	timer.timeout.connect(add_score_per_second)
	add_child(timer)
	timer.start()

func add_score_per_second():
	add_score(score_per_second)

func add_score(amount : int):
	score += amount
	on_score_update.emit(score)
