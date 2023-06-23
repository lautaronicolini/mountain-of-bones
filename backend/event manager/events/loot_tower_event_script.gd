extends Event

var character
var main_scene

func _ready():
	type = "Loot Tower"
	description = "Encontras un torreon abandonado, la
puerta esta cerrada pero se ve deteriora- 
da por el paso del tiempo. Podes intentar 
abrirla pero vas a perder mucho tiempo."

func execute_event(_character, scene_node):
	main_scene = scene_node
	character = _character
	var option_0 = create_option("Intentar saquear la 
	torre", loot_outcome)
	options_array.append(option_0)
	var option_1 = create_option("No hay tiempo,
	seguis tu camino", ignore_outcome)
	options_array.append(option_1)
	show_event_display_with_options(scene_node)

func loot_outcome():
	options_array[0].close_display()
	character.loot_gold(12)
	get_children()[0].execute_event(character, main_scene)

func ignore_outcome():
	options_array[1].close_display()
	get_children()[1].execute_event(character, main_scene)
