extends Node

@export var trigger_probability: float = 1
@export var cooldown_time : float = 4.0
@onready var random = RandomNumberGenerator.new()
var is_active: bool = false
signal trigger_chaos


var cooldown := true
var timer : Timer

func _ready():
	timer = Timer.new()
	timer.wait_time = cooldown_time
	timer.one_shot = true
	timer.timeout.connect(end_cooldown)
	add_child(timer)
	timer.start()
	
	random.randomize()
	ChaosManager.chaos_tick.connect(should_trigger)

func deactivate_chaos():
	is_active = false
	timer.start()

func end_cooldown():
	cooldown = false
	
func activate_chaos():
	cooldown = true
	is_active = true
	trigger_chaos.emit()

func should_trigger():
	if cooldown: # Otherwise they trigger constantly even when cleared
		return
	
	var random_float = random.randfn()
	if random_float < trigger_probability:
		activate_chaos()
		
	
