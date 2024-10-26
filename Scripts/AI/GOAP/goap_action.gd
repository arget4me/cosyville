extends Node

class_name goap_action

var satisfies = []
var requirements = []

func _init(satisfies, requirements):
	self.satisfies = satisfies
	self.requirements = requirements
