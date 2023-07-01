extends ResistanceItem

class_name CrownOfFire

func _init():
	action_description = ""
	tooltip_description = "Corona de Fuego\nOtorga +2 de fuerza"
	price = 25
	image_path = "res://frontend/props/crown_of_fire_icon.png"
	equipment_slot = EquipmentSlotType.HEAD
	altered_stat = Character.damage_type.FIRE
	buff_value = 0.8
	character_class = EquipmentClassType.NONE
