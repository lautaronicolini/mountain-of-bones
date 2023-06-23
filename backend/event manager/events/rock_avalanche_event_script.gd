extends Event

var damage = 2
var character

func _ready():
	type = "Rock Avalanche"
	description = "Una avalancha de rocas te cae encima,
	perdes dos vidas"

func execute_event(_character, scene_node):
	character = _character
	var option = create_option("De acuerdo", event_outcome)
	options_array = [option]
	show_event_display_with_options(scene_node)
	
func event_outcome():
	options_array[0].close_display()
	character.receive_damage(damage)
