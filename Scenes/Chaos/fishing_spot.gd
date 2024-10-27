extends Node2D

func _ready():
	ActionPointsManager.register_action_point(position, ActionPointsManager.action_point_type.FISH)
