extends Event

@export_multiline var info_description:String
@export var event_type:String
@export var option_description:String

var character 

func _ready():
	type = event_type
	description = info_description

func execute_event(_character, scene_node):
	character = _character
	var option_0 = create_option(option_description, close_dialog)
	options_array = [option_0]
	show_event_display_with_options(scene_node)

func close_dialog():
	options_array[0].close_display()
	character.gain_xp(1)
