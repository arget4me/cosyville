extends Node

var number_of_villagers = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_villager_death():
	number_of_villagers -= 1
	if(number_of_villagers <= 0):
		GameManager.transition_to_state(GameManager.game_state.GAME_OVER)
	
func _on_villager_spawned():
	number_of_villagers += 1
