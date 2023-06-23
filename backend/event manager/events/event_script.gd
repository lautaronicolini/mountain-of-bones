extends Node

class_name Event

var type
var description
var option_scene = "res://frontend/event_option.tscn"
var event_display_scene = "res://frontend/event_display.tscn"
var options_array = []
@export var disabled = false

func execute_event(character, scene_node):
	pass

func create_option(label, function):
	var option = load(option_scene)
	option = option.instantiate()
	option.set_label_text(label)
	option.option_chosen.connect(function)
	return option

func show_event_display_with_options(scene, scale = Vector2(0.1, 0.1)):
	var event_scene_instance = load(event_display_scene)
	event_scene_instance = event_scene_instance.instantiate()
	event_scene_instance.set_scale(scale)
	scene.add_child(event_scene_instance, 0)
	event_scene_instance.setup_with_options(options_array, description)
	return event_scene_instance
