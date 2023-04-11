extends Node2D

@onready var path_follow_node = $Path2D/PathFollow2D
@onready var gui = $GUI
var event_display_scene = "res://frontend/event_display.tscn"
var character

func _on_character_select_character_chosen(selected_character):
	selected_character.set_position(Vector2(-1,-9))
	path_follow_node.set_character(selected_character)
	path_follow_node._speed = 50
	selected_character.damage_received.connect(update_life_gui)
	character = selected_character
	update_life_gui()
	
func update_life_gui():
	gui.get_node("Label").set_text(str(character.life_points))
	
func show_event_display_with_options(options_array, description):
	var event_scene_instance = load(event_display_scene)
	event_scene_instance = event_scene_instance.instantiate()
	add_child(event_scene_instance, 0)
	event_scene_instance.setup_with_options(options_array, description)
	
