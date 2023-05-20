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

func get_treat_tree():
	var root = Treat.new(func():pass, "Clase base: Soldado", "res://frontend/props/soldier_icon.png")
	var node1 = Treat.new(evolve_to_paladin, "Nuevo ataque *Rayo de luz*, más poderoso que el ataque normal", "res://frontend/props/paladin_icon.png")
	var node2 = Treat.new(evolve_to_barbarian, "Nuevo ataque *Fuerza bruta*, muy poderoso, pero te hace daño", "res://frontend/props/barbarian_icon.png")
	return [[root], [node1, node2]]
	
func evolve_to_paladin():
	current_display.character.sprite_path = "res://frontend/props/paladin.png"
	current_display.set_sprite()
	actions[0] = Action.new(ray_of_light, "Rayo de luz", "Golpea con un rayo de luz divina más fuerte que un ataque normal", [], func(character_display): character_display.character.enemy.current_display.ray_of_light())

func ray_of_light():
	enemy.receive_damage(2 + strength + 3)

func evolve_to_barbarian():
	current_display.character.sprite_path = "res://frontend/props/barbarian.png"
	current_display.set_sprite()
	actions[0] = Action.new(brute_force, "Fuerza bruta", "Golpea con mucho más fuerte que un ataque normal, pero te daña", [], func(character_display): character_display.attack_movement())
	
func brute_force():
	receive_damage(2)
	enemy.receive_damage(4 + strength + 3)
