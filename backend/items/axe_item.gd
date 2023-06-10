extends EquipableItem

class_name Axe

func _init():
	action_description = ""
	tooltip_description = "Hacha\nOtorga +2 de fuerza"
	price = 50
	image_path = "res://frontend/props/brute_force_icon.png"
	equipment_slot = EquipmentSlotType.WEAPON
	altered_stat = Character.stats.STR
	buff_value = 2
	character_class = EquipmentClassType.SOLDIER
