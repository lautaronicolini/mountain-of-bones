extends EquipableItem

class_name Bow

func _init():
	action_description = ""
	tooltip_description = "Arco\nOtorga +1 de fuerza"
	price = 20
	image_path = "res://frontend/props/ataque_+_icon.png"
	equipment_slot = EquipmentSlotType.WEAPON
	altered_stat = Character.stats.STR
	buff_value = 1
	character_class = EquipmentClassType.ARCHER
