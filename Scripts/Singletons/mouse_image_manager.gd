extends Node

var pointer = load("res://art/cursors/PointingHand.png")
var waterbucket = load("res://art/cursors/WaterBucket.png")
var harpoon = load("res://art/cursors/Harpoon.png")

var pointer_hover = load("res://art/cursors/PointingHand_interactable.png")
var waterbucket_hover = load("res://art/cursors/WaterBucket_interactable.png")
var harpoon_hover = load("res://art/cursors/Harpoon_interactable.png")

enum CURSOR_STATE{POINTER, WATERBUCKET, HARPOON}
var state_stack = []
var current_state = CURSOR_STATE.POINTER

var interactable : bool = false

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
	current_state = state
	set_interactable(interactable)

func set_interactable(value : bool):
	interactable = value
	if current_state == CURSOR_STATE.POINTER:
		Input.set_custom_mouse_cursor(pointer_hover if interactable else pointer)
	if current_state == CURSOR_STATE.WATERBUCKET:
		Input.set_custom_mouse_cursor(waterbucket_hover if interactable else waterbucket)
	if current_state == CURSOR_STATE.HARPOON:
		print("switched to harpoon")
		Input.set_custom_mouse_cursor(harpoon_hover if interactable else harpoon)
