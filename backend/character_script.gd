extends Node2D

class_name Character

@export var life_points = 0
@export var movement_points = 0
@export var max_life = 0
@export var min_life = 0
@export var max_movement_points = 0
@export var min_movement_points = 0
@export var gold = 0
@export var defense = 0
@export var current_tile = 0
@export var strength = 0
@export var sprite_path = ""
@export var items = []
@export var level = 1
@export var experience_points = 0
var enemy
var _movement_points_left = 0
var logger
var rng = RandomNumberGenerator.new()

var actions = [Action.new(attack,"Atacar", "Ataque básico en base a la fuerza del personaje", [], func(character_display): character_display.attack_movement())]
var xp_needed_by_level = {1: 3, 2: 6, 3: 10}
var xp_worth = 2

signal damage_received
signal out_of_sight
signal gold_updated
signal xp_updated
signal healed
signal dead
signal item_consumed

func _init():
	rng.randomize()
	var character_move_points = rng.randi_range(min_movement_points, max_movement_points)
	var character_life_points = rng.randi_range(min_life, max_life)
	life_points = character_life_points
	max_life = character_life_points
	movement_points = character_move_points
	_movement_points_left = character_move_points

func set_logger(_logger):
	logger = _logger

func receive_damage(amount):
	life_points = life_points - (amount - defense)
	defense = clamp(defense - amount, 0, defense)
	emit_signal("damage_received")
	if life_points <= 0:
		emit_signal("dead")

func heal(amount):
	if life_points + amount > max_life:
		life_points = max_life
	else:
		life_points = life_points + amount
	emit_signal("healed")
	
func loot_gold(amount):
	gold += amount
	emit_signal("gold_updated")

func loot_item(item):
	items.append(item)
	
func attack():
	rng.randomize()
	var bonus = rng.randi_range(0, 2)
	enemy.receive_damage(bonus + strength)

func set_enemy(_enemy):
	enemy = _enemy

func update_post_movement():
	_movement_points_left -= 1
	current_tile += 1

func reset_move_points():
	_movement_points_left = movement_points

func consume_item(item):
	item.apply_effect(self)
	emit_signal("item_consumed", item)
	items.erase(item)

func get_actions():
	##TODO: cambiar por fold
	var result = actions.duplicate()
	for item in items:
		result.append(Action.new(consume_item, item.action_description, item.tooltip_description, [item]))
	return result

func gain_xp(amount_gained):
	experience_points += amount_gained
	if experience_points >= xp_needed_by_level[level]:
		experience_points -= xp_needed_by_level[level]
		level += 1
	emit_signal("xp_updated")
