extends Area2D

signal on_clicked()

func _ready() -> void:
	if len(on_clicked.get_connections()) == 0:
		on_clicked.connect(_on_add_score)

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("click"):
		on_clicked.emit()

func _on_add_score():
	ClickingManager.add_score(1)
