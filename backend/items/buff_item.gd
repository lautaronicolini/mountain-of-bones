extends EquipableItem

class_name BuffItem

func apply_buff(character):
	character.modifiers[altered_stat] += buff_value

func unequip(character):
	character.modifiers[altered_stat] -= buff_value
