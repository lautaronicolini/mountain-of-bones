extends EquipableItem

class_name Sword

func _init():
	action_description = ""
	tooltip_description = "Espada\nOtorga +1 de fuerza"
	price = 20
	image_path = "res://frontend/props/attack_icon.png"
	equipment_slot = EquipmentSlotType.WEAPON
	altered_stat = Character.stats.STR
	buff_value = 1
	character_class = EquipmentClassType.SOLDIER
