extends PanelContainer


func _on_pointer_pressed() -> void:
	MouseImageManager.set_cursor(MouseImageManager.CURSOR_STATE.POINTER)

func _on_waterbucket_pressed() -> void:
	MouseImageManager.set_cursor(MouseImageManager.CURSOR_STATE.WATERBUCKET)
