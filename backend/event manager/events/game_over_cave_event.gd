extends Event

func _ready():
	type = "GameOver"
	description = "El enemigo fue mucho para vos,
	es el fin de tu aventura"

func execute_event(_character, scene_node):
	var option = create_option("Fin del juego", end_game)
	options_array = [option]
	show_event_display_with_options(scene_node, Vector2(0.2, 0.2))
	
func end_game():
	options_array[0].close_display()
	get_node("/root/CaveDungeon/GUI").restart_game()
