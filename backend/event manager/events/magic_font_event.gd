extends Event

var character
var main_scene

func _ready():
	type = "Magic Font"
	description = "Encontras una fuente y decidís tomar de 
	ella. 
Sentís como tu fuerza aumenta.
Ganás 3 puntos de experiencia."

func execute_event(_character, scene_node):
	character = _character
	var option_0 = create_option("Perfecto", xp_gain)
	options_array.append(option_0)
	scene_node.show_event_display_with_options(self)
	
func xp_gain():
	options_array[0].close_display()
	character.gain_xp(3)
