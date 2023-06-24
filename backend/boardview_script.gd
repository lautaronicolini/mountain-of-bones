extends Node2D

@onready var path_follow_node = $Path2D/PathFollow2D
@onready var gui = $GUI
@onready var turn_label = $GUI/TurnLabel
@onready var turn = 0
@onready var logger = $Logger
@onready var start_camera = $Camera2D

var character
var character_camera

func _ready():
	logger.flush()
	gui.get_node("Button").pressed.connect(start_turn)
	gui.get_node("Timer").timeout.connect(_on_timer_timeout)

func _on_character_select_character_chosen(selected_character_scene):
	var selected_character = selected_character_scene.character
	logger.log("Personaje elegido. Vida: " + str(selected_character.life_points) + " - Puntos de movimiento: " + str(selected_character.movement_points))
	selected_character.set_logger(logger)
	path_follow_node.set_character(selected_character_scene)
	selected_character_scene.set_position(Vector2(-1,-9))
	
	character_camera = Camera2D.new()
	character_camera.set_enabled(false)
	character_camera.set_position_smoothing_enabled(true)
	character_camera.set_position_smoothing_speed(5)
	character_camera.set_zoom(Vector2(4, 4))
	selected_character_scene.add_child(character_camera)
	selected_character_scene.disable_collition_monitoring()
	
	selected_character.out_of_sight.connect(camera_follow_character)
	gui.set_character(selected_character)
	
	character = selected_character
	path_follow_node.toggle_movement()
	
	character.loot_item(PotionOfLife.new())
	character.loot_item(CrownOfFire.new())
	character.loot_gold(30)

#func show_event_display_with_options(event):
#	logger.log("Comienza evento: " + event.type)
#	var event_scene_instance = load(event_display_scene)
#	event_scene_instance = event_scene_instance.instantiate()
#	add_child(event_scene_instance, 0)
#	event_scene_instance.setup_with_options(event.options_array, event.description)

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
	disable_start_camera()
	character_camera.set_enabled(true)
	gui.hide()
	$Path2D/PathFollow2D/CollitionCharacter.monitoring = false
	$Outro/Timer.start()

func disable_character_camera():
	character_camera.set_enabled(false)

func disable_start_camera():
	start_camera.set_enabled(false)

func enable_start_camera():
	start_camera.set_enabled(true)

func _on_move_button_pressed():
	start_turn()

func _on_continuar_pressed():
	$EventManager.trigger_dungeon_event(character)

func _show_restart_button():
	$Outro/Continuar.show()

