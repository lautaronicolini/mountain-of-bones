extends Event

var character

func _ready():
	type = "Forgotten Camp"
	description = "Encuentras los restos de un
	campamento olvidado. Los restos del
	fuego te sirven para prender una hoguera
	y recuperar toda tu salud."

func execute_event(_character, scene_node):
	character = _character
	var option = create_option("De acuerdo", event_outcome)
	options_array = [option]
	show_event_display_with_options(scene_node, Vector2(0.2, 0.2))
	
func event_outcome():
	options_array[0].close_display()
	character.heal(character.get_max_life())
