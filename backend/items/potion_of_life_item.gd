extends BaseItem

class_name PotionOfLife

func _init():
	action_description = "Consumir Pocion"
	tooltip_description = "Cura 5 puntos de vida"

func apply_effect(character):
	character.heal(5)

func animation_effect(character_display):
	character_display.ray_of_light()
