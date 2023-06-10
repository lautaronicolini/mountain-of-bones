extends Node2D

var character

func set_character(_character):
	character = _character
	$STR_V.set_text(str(character.strength))
	$MOV_V.set_text(str(character.movement_points))
	$LIF_V.set_text(str(character.max_life))
	$DEF_V.set_text(str(character.defense))
	update()

func update():
	var label_template = "%s_B_V"
	for stat in Character.stats:
		var value = character.modifiers[Character.stats[stat]]
		var modifier = "+"
		var label = get_node(label_template % str(stat))
		var color = Color(0, 0, 0)
		
		if value > 0:
			color = Color.FOREST_GREEN
		elif value < 0:
			color = Color.DARK_RED
			modifier = "-"
		
		label.set_text(modifier + str(character.modifiers[Character.stats[stat]]))
		label.set("theme_override_colors/font_color", color)
