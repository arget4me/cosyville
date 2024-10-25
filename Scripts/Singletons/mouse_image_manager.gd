extends Node

var pointer = load("res://art/PointingHand.png")
var waterbucket = load("res://art/WaterBucket.png")

enum CURSOR_STATE{POINTER, WATERBUCKET}
var state_stack = []

func _ready() -> void:
	push_cursor(CURSOR_STATE.POINTER)

func push_cursor(state : CURSOR_STATE):
	if len(state_stack) >= 1:
		if state_stack[len(state_stack) - 1] == state:
			return
	state_stack.append(state)
	set_cursor(state)

func pop_cursor():
	if len(state_stack) >= 2:
		state_stack.erase(len(state_stack) - 1)
		set_cursor(state_stack[len(state_stack) - 1])

func set_cursor(state : CURSOR_STATE):
	if state == CURSOR_STATE.POINTER:
		Input.set_custom_mouse_cursor(pointer)
	if state == CURSOR_STATE.WATERBUCKET:
		Input.set_custom_mouse_cursor(waterbucket)
