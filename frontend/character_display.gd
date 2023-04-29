extends Node2D

var character

func set_sprite():
	$Sprite2D.set_texture(load(character.sprite_path))

func set_character(_character):
	character = _character

