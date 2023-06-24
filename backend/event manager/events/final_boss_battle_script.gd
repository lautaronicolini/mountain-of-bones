extends Event

var character
var main_scene

func _ready():
	type = "Final Boss Battle"
	description = "Te encontrás de frente al
	umbral de una habitación enorme
	dentro de la cueva. Se nota que
	no es de origen natural."

func execute_event(_character, scene_node):
	main_scene = scene_node
	character = _character
	var option_0 = create_option("Continuar", continuar)
	options_array.append(option_0)
	show_event_display_with_options(scene_node, Vector2(0.2, 0.2))
	
func continuar():
	options_array[0].close_display()
	description = "Desde dentro sientes una voz
	profunda que te llama.
	-Adelante aventurero, soy 
	el guardian de la entrada
	a la montaña, preparate para 
	morir!."
	
	var option_0 = create_option("Hora de la 
	batalla", trigger_battle_scene)
	options_array = [option_0]
		
	var event_scene_instance = load("res://frontend/event_display.tscn").instantiate()
	main_scene.add_child(event_scene_instance, 0)
	event_scene_instance.setup_with_options(options_array, description)
	event_scene_instance.set_scale(Vector2(0.2, 0.2))
	
func trigger_battle_scene():
	var battle_scene = load("res://frontend/combat_scene.tscn").instantiate()
	battle_scene.set_battle(character, FireLich.new())
	battle_scene.player_won.connect(player_won_outcome)
	battle_scene.enemy_won.connect(enemy_won_outcome)
	main_scene.disable_start_camera()
	get_tree().root.add_child(battle_scene, 0)

func player_won_outcome():
	get_node("/root/CombatScene").queue_free()
	options_array[0].close_display()
	get_children()[0].execute_event_with_scale(character, main_scene, Vector2(0.2, 0.2))
	character.current_display.disable_collition_monitoring()
	main_scene.enable_start_camera()

func enemy_won_outcome():
	get_node("/root/CombatScene").queue_free()
	options_array[0].close_display()
	get_children()[1].execute_event(character, main_scene)
	main_scene.enable_start_camera()
