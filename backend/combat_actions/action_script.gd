extends Control

class_name Action

var action_function
var description
var parameters
var tooltip_description
var animation_function

signal execute_action

func _init(_action_function, _description, _tooltip_desc, _parameters = [], _animation_function = func():pass):
	action_function = _action_function
	description = _description
	tooltip_description = _tooltip_desc
	parameters = _parameters
	animation_function = _animation_function

func apply_animation(character_display):
	animation_function.callv([character_display])
