extends Node2D

var character_scene = load("res://frontend/character.tscn")
var characters = []
@onready var rng = RandomNumberGenerator.new()
@onready var character_holders = [$Character1Holder, $Character2Holder]

signal character_chosen

func _ready():
	generate_characters()

func generate_characters():
	for i in range(2):
		rng.randomize()
		#Si sale 0 es soldado si sale 1 es arquero. Mejora: guardar colección de clases posibles para iterar sobre ella
		var character_definer = rng.randi_range(0, 1)
		var character_lp = 0
		var character_mp = 0
		var character_sprite = ""
		#Las clases deben almacenar los valores mínimos y máximos de cada stat para la generación. Primera imple con if. Mejorar.
		if character_definer == 0:
			character_lp = rng.randi_range(8, 12)
			character_mp = rng.randi_range(1, 2)
			character_sprite = "res://frontend/props/soldier.png"
		else:
			character_lp = rng.randi_range(6, 9)
			character_mp = rng.randi_range(2, 3)
			character_sprite = "res://frontend/props/archer.png"
		var char_instance = character_scene.instantiate()
		char_instance.initialize(character_lp, character_mp, character_sprite)
		characters.append(char_instance)
		character_holders[i].set_character(char_instance)
func _on_refresh_pressed():
	characters = []
	generate_characters()
