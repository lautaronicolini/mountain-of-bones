extends Sprite2D

var item
var character
@export var slot_type:EquipableItem.EquipmentSlotType

func set_character(_character):
	character = _character
	var equiped_item = character.equiped_items[slot_type]
	if equiped_item != null:
		set_item(equiped_item)

func set_item(_item):
	if slot_type == _item.equipment_slot:
		character.equip(_item)
		if character.equiped_items[slot_type] == _item:
			item = _item
			set_image(item.image_path)

func set_image(image_path):
	$ItemSprite.set_texture(load(image_path))
