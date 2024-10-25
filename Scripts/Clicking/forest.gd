extends Sprite2D

func _on_area_2d_mouse_entered() -> void:
	MouseImageManager.push_cursor(MouseImageManager.CURSOR_STATE.WATERBUCKET)


func _on_area_2d_mouse_exited() -> void:
	MouseImageManager.pop_cursor()
