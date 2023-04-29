extends Character

class_name SoldierClass

func _init():
	max_life = 12
	min_life = 10
	max_movement_points = 2
	min_movement_points = 1
	strength = 2
	sprite_path = "res://frontend/props/soldier.png"
	super()
