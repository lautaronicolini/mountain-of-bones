extends Node2D

var character_display = load("res://frontend/character.tscn").instantiate()
var character
var path_follow
var move_active = false
var speed = 50

func _ready():
	$Camera2D.enabled = true
	var soldi = SoldierClass.new()
	soldi.loot_item(Sword.new())
	set_way(soldi, "HardPath")
	$GUI.get_node("Button").pressed.connect(func (): move_active = true)

func set_character(_character):
	character = _character
	character_display.set_character(character)
	character_display.set_sprite()
	character_display.set_scale(Vector2(2.75, 2.75))
	character.current_display = character_display
	$GUI.set_character(character)

func set_way(_character, challenge):
	set_character(_character)
	path_follow = get_node(challenge).get_child(0)
	path_follow.add_child(character_display)

func _physics_process(delta):
	if move_active:
		path_follow.set_progress(path_follow.get_progress() + speed * delta)
