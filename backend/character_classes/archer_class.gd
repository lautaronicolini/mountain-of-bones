extends Character

class_name ArcherClass

func _init():
	max_life = 10
	min_life = 8
	max_movement_points = 2
	min_movement_points = 2
	strength = 2
	sprite_path = "res://frontend/props/archer.png"
	actions.append(Action.new(focus_attack, "Ataque+"))
	super()

func focus_attack():
	rng.randomize()
	var bonus = rng.randi_range(0, 2)
	enemy.receive_damage(bonus + strength + 3)
