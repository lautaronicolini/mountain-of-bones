extends Node2D

class_name Character

#STATS
enum stats {STR, MOV, LIF, DEF}
@export var strength = 0
@export var movement_points = 0
@export var max_life = 0
@export var defense = 0

#MODIFIERS
var modifiers = {stats.STR: 0, stats.MOV: 0, stats.LIF: 0, stats.DEF:0}

#STATUS TRACKING
@export var life_points = 0
@export var gold = 0
@export var current_tile = 0
@export var items = []
var equiped_items = [null, null, null]
@export var level = 1
@export var experience_points = 0

@export var min_life = 0
@export var max_movement_points = 0
@export var min_movement_points = 0
@export var sprite_path = ""

var enemy
var current_display
var _movement_points_left = 0
var logger
var rng = RandomNumberGenerator.new()
var equipment_class

var actions = [Action.new(attack,"Atacar", "Ataque básico en base a la fuerza del personaje", "res://frontend/props/attack_icon.png", [], func(character_display, action): character_display.attack_movement(action))]
var xp_needed_by_level = {1: 3, 2: 6, 3: 10}
var xp_worth = 2

signal damage_received
signal out_of_sight
signal gold_updated
signal xp_updated
signal healed
signal dead
signal item_looted
signal item_equiped
signal item_consumed
signal leveled_up
signal shield_raised
signal could_not_equip_on_class

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
	
func set_enemy(_enemy):
	enemy = _enemy

#GETTERS
func get_actions():
	return actions

func get_strength():
	return strength + modifiers[stats.STR]

func get_max_life():
	return max_life + modifiers[stats.LIF]


#MOVEMENT
func update_post_movement():
	_movement_points_left -= 1
	current_tile += 1

func reset_move_points():
	_movement_points_left = movement_points

#COMBAT
func receive_damage(amount):
	life_points = life_points - (amount - defense)
	defense = clamp(defense - amount, 0, defense)
	emit_signal("damage_received")
	if life_points <= 0:
		emit_signal("dead")

func heal(amount):
	life_points = clamp(life_points + amount, 0, get_max_life())
	emit_signal("healed")

func attack():
	rng.randomize()
	var bonus = rng.randi_range(0, 2)
	enemy.receive_damage(bonus + get_strength())

#GOLD
func loot_gold(amount):
	gold += amount
	emit_signal("gold_updated")
	
func lose_gold(amount):
	gold -= clamp(0, 9999, amount)
	emit_signal("gold_updated")

#ITEMS
func loot_item(item):
	items.append(item)
	emit_signal("item_looted")
	item.generate_action_for_character(self, consume_item)

func consume_item(item):
	item.apply_effect(self)
	items.erase(item)
	actions.erase(item.action_object)
	emit_signal("item_consumed")
	
func equip(item):
	return item.be_equiped(self)

#LEVEL
func gain_xp(amount_gained):
	experience_points += amount_gained
	if experience_points >= xp_needed_by_level[level]:
		experience_points -= xp_needed_by_level[level]
		level += 1
		emit_signal("leveled_up")
	emit_signal("xp_updated")
