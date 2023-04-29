extends Control

class_name Action

var action_function
var description
var parameters

func _init(_action_function, _description, _parameters = []):
	action_function = _action_function
	description = _description
	parameters = _parameters
