extends Node

class_name Treat

var treat_function
var treat_tooltip
var treat_image_path
var treat_function_parameters

func _init(_treat_function, _treat_tooltip, _treat_image_path, _treat_function_parameters = []):
	treat_function = _treat_function
	treat_tooltip = _treat_tooltip
	treat_image_path = _treat_image_path
	treat_function_parameters = _treat_function_parameters

func apply_treat(character):
	treat_function.callv(treat_function_parameters)
