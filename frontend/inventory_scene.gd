extends Node2D

var x = 0
var y = 0
var character

func set_character(_character):
	character = _character
	character.item_looted.connect(update)
	character.item_consumed.connect(update)
	update()

func update():
	clear_tiles()
	var index = 0
	for item in character.items:
		var item_tile = load("res://frontend/item_inventory_tile.tscn").instantiate()
		item_tile.set_position(Vector2(x,y))
		item_tile.set_scale(Vector2(0.15,0.15))
		item_tile.set_item(item)
		$ItemTiles.add_child(item_tile)
		index += 1
		if index % 3 == 0:
			y += 20
			x = 0
		else:
			x += 20
	x = 0
	y = 0

func clear_tiles():
	for child in $ItemTiles.get_children():
		child.queue_free()
