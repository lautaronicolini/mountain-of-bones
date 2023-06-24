extends Character

class_name FireLich

func _init():
	max_life = 25
	min_life = 25
	max_movement_points = 1
	min_movement_points = 1
	strength = 2
	sprite_path = "res://frontend/props/fire_lich.png"
	actions = [Action.new(attack, "Ataque", "Ataque normal", "res://frontend/props/attack_icon.png", [], func(character_display, action): character_display.attack_movement(action))]
	xp_worth = 10
	super()

#Fire Lich
func attack():
	enemy.receive_damage(2)

func enemy_action():
	var attack = actions[0]
	attack.emit_signal("execute_action", attack)
