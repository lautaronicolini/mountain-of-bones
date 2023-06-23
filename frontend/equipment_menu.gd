extends Node2D

var character
var class_error_label_template_text = "No se puede equipar ese item en la clase %s"

func set_character(_character):
	character = _character
	set_character_sprite()
	character.item_equiped.connect(update_interface)
	character.item_looted.connect(update_interface)
	
	$ItemGrid.tile_scene_path = "res://frontend/equipment_tile.tscn"
	$ItemGrid.distance = 100
	update_interface()

	for slot in $EquipmentSlots.get_children():
		slot.set_character(character)
		
	character.could_not_equip_on_class.connect(equip_class_error)
		
func set_character_sprite():
	$CharacterSprite.set_texture(load(character.sprite_path))
	
func update_interface():
	$StatSheet.set_character(character)
	var equipable_items = character.items.filter(func(item): return item.get_item_type() == BaseItem.ItemType.EQUIPABLE)
	$ItemGrid.update_items(equipable_items)

func _on_close_pressed():
	hide()

func equip_class_error(class_text):
	$ClassErrorLabel.set_text(class_error_label_template_text % class_text)
	$ClassErrorLabel.visible = true
	$Timer.start()

func _on_timer_timeout():
	$ClassErrorLabel.visible = false
