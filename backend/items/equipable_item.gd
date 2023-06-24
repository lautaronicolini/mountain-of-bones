extends BaseItem

class_name EquipableItem

enum EquipmentSlotType {HEAD, BODY, WEAPON}
enum EquipmentClassType {SOLDIER, ARCHER, NONE}

var equipment_slot:EquipmentSlotType
var character_class:EquipmentClassType
var altered_stat
var buff_value
var class_error_info = ["Soldado", "Arquero"]

func be_equiped(character):
	if (character.equipment_class == character_class) || (character_class == EquipmentClassType.NONE):
		var currently_equipped_item = character.equiped_items[equipment_slot]
		if currently_equipped_item != null:
			currently_equipped_item.unequip(character)
			character.loot_item(currently_equipped_item)
		character.equiped_items[equipment_slot] = self
		character.items.erase(self)
		apply_buff(character)
		character.emit_signal("item_equiped")
	else:
		character.emit_signal("could_not_equip_on_class", class_error_info[character.equipment_class])

func apply_buff(character):
	pass

func unequip(character):
	pass

func get_item_type():
	return ItemType.EQUIPABLE

func is_valid_trade(character):
	return character.gold >= price && (character.equipment_class == character_class || character_class == EquipmentClassType.NONE)
