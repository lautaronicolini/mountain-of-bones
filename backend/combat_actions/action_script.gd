extends Node2D

class_name Action

func initialize(action_function, description):
	$Button.pressed.connect(action_function)
	$Button.set_text(description)
