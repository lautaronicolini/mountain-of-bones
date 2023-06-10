extends Node2D

var x = 0
var y = 0
@export var tile_scene_path = "res://frontend/item_inventory_tile.tscn"
@export var tile_scale = Vector2(1,1)
@export var columns = 3
@export var distance = 20

func update_items(items):
	clear_tiles()
	var index = 0
	for item in items:
		var item_tile = load(tile_scene_path).instantiate()
		item_tile.set_position(Vector2(x,y))
		item_tile.set_scale(tile_scale)
		item_tile.set_item(item)
		add_child(item_tile)
		index += 1
		if index % columns == 0:
			y += distance
			x = 0
		else:
			x += distance
	x = 0
	y = 0

func clear_tiles():
	for child in get_children():
		child.queue_free()
