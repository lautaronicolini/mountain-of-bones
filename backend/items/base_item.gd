extends Node

class_name BaseItem

enum ItemType {EQUIPABLE, CONSUMABLE}

var action_description
var tooltip_description
var price
var image_path
var animation_path
var spawn_point
var action_object

func apply_effect(_character):
	pass

func be_equiped(_character):
	pass

func generate_action_for_character(character, character_function):
	pass

func get_item_type():
	pass

func is_valid_trade(character):
	pass
