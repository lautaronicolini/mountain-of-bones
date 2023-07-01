extends Character

class_name FireLich

var current_attack
var phase2 = false

func _init():
	max_life = 30
	min_life = 30
	max_movement_points = 1
	min_movement_points = 1
	strength = 2
	sprite_path = "res://frontend/props/fire_lich.png"
	actions = [
		Action.new(attack, "Ataque", "Ataque normal", "res://frontend/props/attack_icon.png", [], func(character_display, action): character_display.play_animation("res://frontend/animations/fire_spell.tscn", "SpellSpawnPoint", action)),
		Action.new(rain_of_fire, "Lluvia de fuego", "Ataque de fuego muy fuerte ", "res://frontend/props/attack_icon.png", [], func(character_display, action): character_display.character.enemy.current_display.play_animation("res://frontend/animations/rain_of_fire.tscn", "RainSpawnPoint", action))]
	xp_worth = 0
	current_attack = actions[0]
	super()

#Fire Lich
func attack():
	enemy.receive_damage(4, Character.damage_type.FIRE)

func rain_of_fire():
	enemy.receive_damage(10, Character.damage_type.FIRE)

func enemy_action():
	if (!phase2 && life_points > (max_life * 0.6)) || phase2:
		current_attack.emit_signal("execute_action", current_attack)
	else:
		phase2 = true
		phase_change()

func phase_change():
	current_display.get_parent().start_shaking()
	current_display.get_node("AudioStreamPlayer2D").stream = load("res://frontend/props/SFX/roar.wav")
	current_display.get_node("AudioStreamPlayer2D").play()
	current_attack = actions[1]
