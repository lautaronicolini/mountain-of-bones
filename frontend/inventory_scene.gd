extends Node2D

var x = 0
var y = 0
var character
var disabled = true

func set_character(_character):
	disabled = false
	character = _character
	character.item_looted.connect(update_item_grid)
	character.item_consumed.connect(update_item_grid)
	$ItemGrid.tile_scene_path = "res://frontend/item_inventory_tile.tscn"
	$ItemGrid.tile_scale = Vector2(0.15,0.15)
	update_item_grid()

func update_item_grid():
	$ItemGrid.update_items(character.items)

func _physics_process(delta):
	if !disabled:
		update_item_grid()
