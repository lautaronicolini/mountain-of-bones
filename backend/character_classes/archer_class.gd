extends Character

class_name ArcherClass

func _init():
	equipment_class = EquipableItem.EquipmentClassType.ARCHER
	max_life = 9
	min_life = 8
	max_movement_points = 2
	min_movement_points = 2
	strength = 2
	sprite_path = "res://frontend/props/archer.png"
	actions = [Action.new(focus_attack, "Ataque+", "Ataque más fuerte que el común, varía en intensidad", "res://frontend/props/ataque_+_icon.png", [], func(character_display, action): character_display.play_animation("res://frontend/animations/Arrow.tscn", "ArrowSpawnPoint", action))]
	super()

func focus_attack():
	rng.randomize()
	var bonus = rng.randi_range(0, 2)
	enemy.receive_damage(bonus + get_strength() + 3)

func get_treat_tree():
	var root = Treat.new(func():pass, "Clase base: Arquero", "res://frontend/props/archer_icon.png")
	var node1 = Treat.new(evolve_to_fire_archer, "Nuevo ataque *Flecha de fuego*, más poderoso y hace daño de fuego", "res://frontend/props/fire_archer_icon.png")
	var node2 = Treat.new(gain_life, "Ganas 5 puntos de vida", "res://frontend/props/gain_health_icon.png")
	return [[root], [node1, node2]]
	
func evolve_to_fire_archer():
	current_display.character.sprite_path = "res://frontend/props/fire_archer.png"
	current_display.set_sprite()
	actions[0] = Action.new(fire_arrow, "Flecha de fuego", "Más poderoso y hace daño de fuego", "res://frontend/props/ataque_+_icon.png", [], func(character_display, action): character_display.play_animation("res://frontend/animations/fire_arrow.tscn", "ArrowSpawnPoint", action))

func fire_arrow():
	rng.randomize()
	var bonus = rng.randi_range(0, 2)
	enemy.receive_damage(bonus + get_strength() + 5, Character.damage_type.FIRE)

func gain_life():
	life_points += 5
	modifiers[stats.LIF] += 5
	emit_signal("healed")
