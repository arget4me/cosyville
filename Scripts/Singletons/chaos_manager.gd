extends Node

var triggerables = []
signal chaos_tick

# tick_interval sets how frequently we check if random chaos should trigger
var tick_interval = 0
func _process(delta):
	if tick_interval == 100:
		tick_interval = 0
		chaos_tick.emit()
	tick_interval += 1
	
