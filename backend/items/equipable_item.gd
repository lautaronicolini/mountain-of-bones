extends BaseItem

class_name EquipableItem

enum EquipmentSlotType {HEAD, BODY, WEAPON}
enum EquipmentClassType {SOLDIER, ARCHER}

var equipment_slot
var character_class
var altered_stat
var buff_value

func be_equiped(character):
	if character.equipment_class == character_class:
		var currently_equipped_item = character.equiped_items[equipment_slot]
		if currently_equipped_item != null:
			currently_equipped_item.unequip()
			character.loot_item(currently_equipped_item)
		character.equiped_items[equipment_slot] = self
		character.items.erase(self)
		apply_buff(character)

func apply_buff(character):
	character.modifiers[altered_stat] += buff_value

func unequip(character):
	character.modifiers[altered_stat] -= buff_value
