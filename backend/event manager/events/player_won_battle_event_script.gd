extends Event

@export_multiline var info_description:String
@export var event_type:String
@export var option_description:String

var character

func _ready():
	type = event_type
	description = info_description

func execute_event(_character, scene_node):
	var option_0 = create_option(option_description, close_dialog)
	options_array = [option_0]
	character = _character
	show_event_display_with_options(scene_node)

func execute_event_with_scale(_character, scene_node, scale):
	var option_0 = create_option(option_description, close_dialog)
	options_array = [option_0]
	character = _character
	show_event_display_with_options(scene_node, scale)

func close_dialog():
	character.gain_xp(character.enemy.xp_worth)
	options_array[0].close_display()
