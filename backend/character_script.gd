extends Node2D

@export var life_points = 0:
	get:
		return life_points
	set(value):
		life_points = value
@export var movement_points = 0:
	get:
		return movement_points
	set(value):
		movement_points = value
@export var gold = 0
var _movement_points_left = 0
@export var current_tile = 0
@export var texture_path = ""
var logger
@onready var sprite = $Sprite2D
@onready var collition_area = $CollitionCharacter/CollisionShape2D

signal damage_received
signal out_of_sight
signal gold_updated

func initialize(lp, mp, sprite_path):
	life_points = lp
	movement_points = mp
	texture_path = sprite_path
	_movement_points_left = mp

# Called when the node enters the scene tree for the first time.
func _ready():
	collition_area = $CollitionCharacter
	set_character_texture(texture_path)

func set_character_texture(texture_to_set):
	texture_path = texture_to_set
	sprite.set_texture(load(texture_to_set))

func set_logger(_logger):
	logger = _logger

func receive_damage(amount):
	life_points = life_points - amount
	emit_signal("damage_received")

func loot_gold(amount):
	gold += amount
	emit_signal("gold_updated")
	
func _physics_process(_delta):
	if !collition_area.get_overlapping_areas().is_empty():
		var collitioned_tile = collition_area.get_overlapping_areas()[0]
		if !collitioned_tile.has_been_passed():
			collitioned_tile.mark_as_passed()
			_movement_points_left -= 1
			current_tile += 1
			if current_tile >= 4:
				emit_signal("out_of_sight")
			elif _movement_points_left == 0:
				logger.log("Casillero actual: " + str(current_tile))
				collitioned_tile.spawn_event(self)
				get_parent()._speed = 0
				_movement_points_left = movement_points
