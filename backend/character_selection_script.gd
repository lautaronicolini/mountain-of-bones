extends Node2D

var character_scene = load("res://frontend/character.tscn")
var characters = []
@onready var rng = RandomNumberGenerator.new()
@onready var character_holders = [$Character1Holder, $Character2Holder]
@onready var character_classes = [ArcherClass, SoldierClass]

signal character_chosen

func _ready():
	generate_characters()

func generate_characters():
	for i in range(2):
		rng.randomize()
		var character_class_index = rng.randi_range(0, character_classes.size() - 1)
		var char_instance = character_classes[character_class_index].new()
		var char_scene = character_scene.instantiate()
		char_scene.set_character(char_instance)
		char_scene.set_sprite()
		characters.append(char_scene)
		character_holders[i].set_character(char_scene)

func _on_refresh_pressed():
	characters = []
	generate_characters()
