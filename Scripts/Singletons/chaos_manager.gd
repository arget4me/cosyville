extends Node

var triggerables = []
signal chaos_tick

func _ready():
	var timer := Timer.new()
	timer.one_shot = false
	timer.wait_time = 5.0
	timer.timeout.connect(trigger_chaos)
	add_child(timer)
	timer.start()

func trigger_chaos():
	chaos_tick.emit()
	
