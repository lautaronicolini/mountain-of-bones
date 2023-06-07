extends Node2D

func set_item(item):
	$ItemSprite.set_texture(load(item.image_path))
