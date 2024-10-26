extends Area2D

signal on_clicked()
@export var sfx_name : String = 'click'

func _ready() -> void:
	if len(on_clicked.get_connections()) == 0:
		on_clicked.connect(_on_add_score)
	
	on_clicked.connect(_on_clicked_play_sound)

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("click"):
		on_clicked.emit()

func _on_add_score():
	ClickingManager.add_score(1)

func _on_clicked_play_sound():
	SoundManager.play_sfx(sfx_name)
