extends Node

var triggerables = []
var max_concurrent_triggers = 5
signal chaos_tick

func _ready():
	var timer := Timer.new()
	timer.one_shot = false
	timer.wait_time = 5.0
	timer.timeout.connect(trigger_chaos)
	add_child(timer)
	timer.start()

func trigger_chaos():
	max_concurrent_triggers = 3
	chaos_tick.emit()
	
func claim_trigger():
	if max_concurrent_triggers > 0:
		max_concurrent_triggers -= 1
	
func is_allowed_to_trigger():
	if max_concurrent_triggers <= 0:
		return false
	return true
