extends Area2D

signal on_clicked()
signal on_display_clickable()

@export var sfx_name : String = 'click'
@export var pointer_state : MouseImageManager.CURSOR_STATE = MouseImageManager.CURSOR_STATE.POINTER
@export var clicking_is_enabled := true


func _ready() -> void:
	if len(on_clicked.get_connections()) == 0:
		on_clicked.connect(_on_add_score)
	
	on_clicked.connect(_on_clicked_play_sound)

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if not clicking_is_enabled:
		return
	
	if event.is_action_pressed("click") and pointer_state == MouseImageManager.current_state:
		on_clicked.emit()
		on_display_clickable.emit()

func _on_add_score():
	ClickingManager.add_score(1)

func _on_clicked_play_sound():
	SoundManager.play_sfx(sfx_name)

func _on_mouse_entered() -> void:
	MouseImageManager.set_interactable(clicking_is_enabled and pointer_state == MouseImageManager.current_state)

func _on_mouse_exited() -> void:
	MouseImageManager.set_interactable(false)
