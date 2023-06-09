extends Node2D

@onready var path_follow_node = $Path2D/PathFollow2D
@onready var gui = $GUI
@onready var turn_label = $GUI/TurnLabel
@onready var turn = 0
@onready var logger = $Logger
@onready var start_camera = $Camera2D

var event_display_scene = "res://frontend/event_display.tscn"
var character

func _ready():
	logger.flush()
	gui.get_node("Button").pressed.connect(start_turn)
	gui.get_node("Reiniciar").pressed.connect(restart_game)
	gui.get_node("Timer").timeout.connect(_on_timer_timeout)

func _on_character_select_character_chosen(selected_character_scene):
	var selected_character = selected_character_scene.character
	logger.log("Personaje elegido. Vida: " + str(selected_character.life_points) + " - Puntos de movimiento: " + str(selected_character.movement_points))
	selected_character.set_logger(logger)
	path_follow_node.set_character(selected_character_scene)
	selected_character_scene.set_position(Vector2(-1,-9))
	
	var camera = Camera2D.new()
	camera.set_enabled(false)
	camera.set_position_smoothing_enabled(true)
	camera.set_position_smoothing_speed(5)
	camera.set_zoom(Vector2(3.324, 3.324))
	selected_character_scene.add_child(camera)
	selected_character_scene.disable_collition_monitoring()
	
	selected_character.damage_received.connect(update_life_gui)
	selected_character.healed.connect(update_life_gui)
	selected_character.out_of_sight.connect(camera_follow_character)
	selected_character.gold_updated.connect(update_gold_gui)
	selected_character.leveled_up.connect(show_treat_tree)
	gui.get_node("ExperienceBar").request_connect(selected_character)
	gui.get_node("Inventory").set_character(selected_character)
	
	character = selected_character
	update_life_gui()
	update_gold_gui()
	path_follow_node.toggle_movement()
	
	character.loot_item(PotionOfLife.new())
	character.loot_gold(30)
	
	start_turn()
	
func update_life_gui():
	logger.log("Vida del personaje: " + str(character.life_points))
	gui.get_node("LifeLabel").set_text(str(character.life_points))
	
func update_gold_gui():
	logger.log("Oro del personaje: " + str(character.gold))
	gui.get_node("GoldLabel").set_text(str(character.gold))
	
func show_event_display_with_options(event):
	logger.log("Comienza evento: " + event.type)
	var event_scene_instance = load(event_display_scene)
	event_scene_instance = event_scene_instance.instantiate()
	add_child(event_scene_instance, 0)
	event_scene_instance.setup_with_options(event.options_array, event.description)

func start_turn():
	turn = turn + 1
	var info_text = "Comienza el turno: " + str(turn)
	turn_label.set_text(info_text)
	turn_label.show()
	logger.log(info_text)
	gui.get_node("Timer").start()
	path_follow_node._speed = 50

func _on_timer_timeout():
	turn_label.hide()

func camera_follow_character():
	start_camera.set_enabled(false)
	path_follow_node.get_child(1).get_child(-1).set_enabled(true)
	gui.hide()
	$Outro/Timer.start()

func _on_move_button_pressed():
	start_turn()

func _on_reiniciar_pressed():
	restart_game()
	
func restart_game():
	get_tree().get_root().add_child(load("res://frontend/intro.tscn").instantiate())
	queue_free()

func _show_restart_button():
	$Outro/Reiniciar.show()

func show_treat_tree():
	$EventManager.trigger_level_up_event(character)
	
