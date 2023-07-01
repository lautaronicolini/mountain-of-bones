extends Event

var character
var main_scene
var dungeon_scene
var cave_dungeon

func _ready():
	type = "Cave Dungeon"
	description = "¡Bienvenido a la cueva de entrada!

Este es un evento especial llamado
MAZMORRA, donde podés elegir entre dos
caminos y te moves de a un casillero
por vez."

func execute_event(_character, _scene_node):
	character = _character
	main_scene = _scene_node
	
	cave_dungeon = load("res://frontend/cave_dungeon.tscn").instantiate()
	cave_dungeon.set_position(Vector2(-20, -280))
	cave_dungeon.set_z_index(1)
	
	main_scene.disable_character_camera()
	main_scene.disable_start_camera()
	
	get_tree().root.add_child(cave_dungeon, 0)
	dungeon_scene = cave_dungeon
	
	options_array = [create_option("Continuar", continuar)]
	
	var event_scene_instance = load("res://frontend/event_display.tscn").instantiate()
	cave_dungeon.add_child(event_scene_instance, 0)
	event_scene_instance.setup_with_options(options_array, description)
	event_scene_instance.set_scale(Vector2(0.2, 0.2))

func continuar():
	options_array[0].close_display()
	description = "El camino de arriba tiene mejores 
	recompensas y es más difícil. El camino
	de abajo es más sencillo y sus 
	recompensas son peores.
	¿Por qué camino vas a ir?"
	
	var option_0 = create_option("Camino difícil", hard_way)
	var option_1 = create_option("Camino fácil", easy_way)
	options_array = [option_0, option_1]
		
	var event_scene_instance = load("res://frontend/event_display.tscn").instantiate()
	cave_dungeon.add_child(event_scene_instance, 0)
	event_scene_instance.setup_with_options(options_array, description)
	event_scene_instance.set_scale(Vector2(0.2, 0.2))
	
func hard_way():
	dungeon_scene.set_way(character, "HardPath")
	options_array[0].close_display()
	
func easy_way():
	dungeon_scene.set_way(character, "EasyPath")
	options_array[0].close_display()
