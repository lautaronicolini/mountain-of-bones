extends Character

class_name ArcherClass

func _init():
	max_life = 10
	min_life = 8
	max_movement_points = 2
	min_movement_points = 1
	strength = 2
	sprite_path = "res://frontend/props/archer.png"
	actions = [Action.new(focus_attack, "Ataque+", "Ataque más fuerte que el común, varía en intensidad", [], func(character_display): character_display.shoot_arrow())]
	super()

func focus_attack():
	rng.randomize()
	var bonus = rng.randi_range(0, 2)
	enemy.receive_damage(bonus + strength + 3)

func get_treat_tree():
	var root = Treat.new(func():pass, "Clase base: Arquero", "res://frontend/props/archer_icon.png")
	var node1 = Treat.new(gain_strength, "Ganas 2 puntos de fuerza", "res://frontend/props/attack_icon.png")
	var node2 = Treat.new(gain_life, "Ganas 5 puntos de vida", "res://frontend/props/gain_health_icon.png")
	return [[root], [node1, node2]]
	
func gain_strength():
	strength += 2

func gain_life():
	life_points += 5
	max_life += 5
	emit_signal("healed")
	
func brute_force():
	receive_damage(2)
	enemy.receive_damage(4 + strength + 3)
