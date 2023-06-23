extends Character

class_name Bat

func _init():
	max_life = 13
	min_life = 13
	max_movement_points = 1
	min_movement_points = 1
	strength = 0
	sprite_path = "res://frontend/props/bat.png"
	actions = [Action.new(vampirism, "Vampirismo", "Ataque débil pero que cura al usuario", "res://frontend/props/attack_icon.png", [], func(character_display, action): character_display.attack_movement(action))]
	xp_worth = 3
	super()

#Bat
func vampirism():
	enemy.receive_damage(2)
	heal(1)

func enemy_action():
	var vampirism = actions[0]
	vampirism.emit_signal("execute_action", vampirism)
