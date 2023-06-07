extends BaseItem

class_name PotionOfLife

func _init():
	action_description = "Consumir Pocion"
	tooltip_description = "Pocion\nCura 5 puntos de vida"
	price = 50
	image_path = "res://frontend/props/potion_icon.png"

func apply_effect(character):
	character.heal(5)

func animation_effect(character_display):
	character_display.ray_of_light()
