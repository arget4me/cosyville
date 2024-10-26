extends Node

@export var trigger_probability: float = 1
@onready var random = RandomNumberGenerator.new()
var is_active: bool = false
signal trigger_chaos

func _ready():
	random.randomize()
	ChaosManager.chaos_tick.connect(should_trigger)

func deactivate_chaos():
	is_active = false
	
func activate_chaos():
	is_active = true
	trigger_chaos.emit()

func should_trigger():
	var random_float = random.randfn()
	if random_float < trigger_probability:
		activate_chaos()
		
	
