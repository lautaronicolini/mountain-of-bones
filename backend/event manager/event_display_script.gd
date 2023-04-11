extends Node2D

@onready var description_label = $DescriptionLabel
var positions_for_options = [Vector2(318,314), Vector2(833,314), Vector2(318,509), Vector2(833,509)]

#No debería llamarse con más de 4 opciones
func setup_with_options(option_array, description):
	var index = 0
	description_label.set_text(description)
	for option in option_array:
		option.set_position(positions_for_options[index])
		add_child(option)
	

func close_display():
	queue_free()
