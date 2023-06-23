extends Node2D

@onready var description_label = $DescriptionLabel
var positions_for_options = [Vector2(318,509), Vector2(833,509), Vector2(318,314), Vector2(833,314)]

#No debería llamarse con más de 4 opciones
func setup_with_options(option_array, description):
	var index = 0
	set_description_text(description)
	for option in option_array:
		option.set_position(positions_for_options[index])
		add_child(option)
		index += 1

func set_description_text(text):
	description_label.set_text(text)

func set_font_size(size):
	description_label.add_theme_font_size_override("font_size", size)
