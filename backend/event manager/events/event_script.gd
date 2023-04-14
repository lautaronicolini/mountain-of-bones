extends Node

class_name Event

var type
var description
var option_scene = "res://frontend/event_option.tscn"
var options_array = []

func execute_event(character, scene_node):
	pass

func create_option(label, function):
	var option = load(option_scene)
	option = option.instantiate()
	option.set_label_text(label)
	option.option_chosen.connect(function)
	return option
