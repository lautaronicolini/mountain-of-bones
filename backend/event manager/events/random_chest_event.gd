extends Event

var character
var main_scene

func _ready():
	type = "Random Chest"
	description = "Encontras un cofre medio
	enterrado en la cueva. Cuando lo logras
	sacar te invade la adrenalina por saber
	que tiene adentro."

func execute_event(_character, scene_node):
	main_scene = scene_node
	character = _character
	var option_0 = create_option("Abrir el cofre", loot_outcome)
	options_array.append(option_0)
	show_event_display_with_options(scene_node, Vector2(0.2, 0.2))

func loot_outcome():
	options_array[0].close_display()
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	if rng.randi_range(0, 1) == 0:
		character.loot_gold(15)
		get_children()[0].execute_event(character, main_scene)
	else:
		character.heal(7)
		get_children()[1].execute_event(character, main_scene)
	
