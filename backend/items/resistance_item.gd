extends EquipableItem

class_name ResistanceItem

func apply_buff(character):
	character.resistances[altered_stat] += buff_value

func unequip(character):
	character.resistances[altered_stat] -= buff_value
