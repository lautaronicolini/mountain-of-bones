extends Event

var character
var main_scene

func _ready():
	type = "Enemy Soldier Battle"
	description = "Al terminar de subir uncamino muy 
empinado, te topas con un soldado disidente
de otra faccion buscando aventureros
cansados para asaltar."

func execute_event(_character, scene_node):
	main_scene = scene_node
	character = _character
	var option_0 = create_option("Hora de la 
	batalla", trigger_battle_scene)
	options_array.append(option_0)
	scene_node.show_event_display_with_options(self)
	
func trigger_battle_scene():
	var battle_scene = load("res://frontend/combat_scene.tscn").instantiate()
	battle_scene.set_battle(character)
	battle_scene.player_won.connect(player_won_outcome)
	battle_scene.enemy_won.connect(enemy_won_outcome)
	battle_scene.set_position(Vector2(117,490))
	battle_scene.scale = Vector2(0.35, 0.35)
	get_tree().root.add_child(battle_scene, 0)

func player_won_outcome():
	options_array[0].close_display()
	character.gain_xp(2)
	get_children()[0].execute_event(character, main_scene)

func enemy_won_outcome():
	options_array[0].close_display()
	get_children()[1].execute_event(character, main_scene)
