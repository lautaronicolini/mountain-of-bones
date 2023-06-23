extends Node2D

var character_display = load("res://frontend/character.tscn").instantiate()
var character
var path_follow
var move_active = false
var speed = 150
var challenge
var tile = 0

@onready var start_camera = $Camera2D

func _ready():
	$Camera2D.enabled = true
	var soldi = ArcherClass.new()
	soldi.loot_item(Bow.new())
	set_way(soldi, "EasyPath")
	$GUI.get_node("Button").pressed.connect(func (): move_active = true)
	character.current_display.disable_collition_monitoring()

func set_way(_character, _challenge):
	set_character(_character)
	challenge = _challenge
	path_follow = get_node(challenge).get_child(0)
	path_follow.add_child(character_display)
	path_follow.get_children()[0].area_entered.connect(tile_collided)

func set_character(_character):
	character = _character
	character_display.set_character(character)
	character_display.set_sprite()
	character_display.set_scale(Vector2(2.75, 2.75))
	character.current_display = character_display
	$GUI.set_character(character)

func tile_collided(collitioned_tile):
	if !collitioned_tile.has_been_passed():
		move_active = false
		collitioned_tile.mark_as_passed()
		$Events.get_node(challenge).get_children()[tile].execute_event(character, self)
		tile += 1
		if tile == $Events.get_node(challenge).get_child_count():
			tile = 0
			challenge = "FinalEvents"

func disable_start_camera():
	start_camera.set_enabled(false)

func enable_start_camera():
	start_camera.set_enabled(true)

func _physics_process(delta):
	if move_active:
		path_follow.set_progress(path_follow.get_progress() + speed * delta)
		
