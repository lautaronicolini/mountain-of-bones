extends Node

class_name PotionOfLife

var action_description = "Consumir Pocion"

func apply_effect(character):
	character.heal(5)
