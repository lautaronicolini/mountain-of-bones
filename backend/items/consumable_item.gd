extends BaseItem

class_name ConsumableItem

func get_item_type():
	return ItemType.CONSUMABLE

func generate_action_for_character(character, character_function):
	var consumable_item_action = Action.new(character_function, action_description, tooltip_description, image_path, [self], func (character_display, _action): character_display.item_animation(self))
	character.actions.append(consumable_item_action)
	action_object = consumable_item_action
