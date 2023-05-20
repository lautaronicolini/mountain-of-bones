extends Character

class_name SoldierClass

func _init():
	max_life = 12
	min_life = 10
	max_movement_points = 2
	min_movement_points = 1
	strength = 2
	sprite_path = "res://frontend/props/soldier.png"
	actions.append(Action.new(defense_skill, "Defender", "Previene los siguientes 2 puntos de daño", [], func(character_display): character_display.raise_shield()))
	super()

func defense_skill():
	defense += 2
