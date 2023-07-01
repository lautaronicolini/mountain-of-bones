extends Node2D

var character
var stat_scene = "res://frontend/stat_sheet.tscn"

func set_character(_character):
	character = _character
	update()

func update():
	var label_template = "%s_V"
	for type in Character.damage_type:
		var value = character.resistances[Character.damage_type[type]] * 100
		var label = get_node(label_template % str(type))
		var color = Color(0, 0, 0)
		
		if value > 0:
			color = Color.FOREST_GREEN
		elif value < 0:
			color = Color.DARK_RED
		
		label.set_text(str(value))
		label.set("theme_override_colors/font_color", color)


func _on_switch_pressed():
	stat_scene = load(stat_scene).instantiate()
	stat_scene.set_character(character)
	get_parent().add_child(stat_scene)
	stat_scene.set_position(get_position())
	queue_free()
