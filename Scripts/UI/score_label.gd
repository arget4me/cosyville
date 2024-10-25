extends Label

func _ready():
	ClickingManager.on_score_update.connect(_on_score_update)


func _on_score_update(score : int):
	text = "Score: " + str(score)
