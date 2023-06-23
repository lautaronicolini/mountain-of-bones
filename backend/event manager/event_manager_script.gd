extends Node2D

@onready var events = $RandomEvents.get_children()

func _on_trigger_random_event(character):
	var enabled_events = events.filter(func(event):return !event.disabled)
	var index = randi_range(0, enabled_events.size() -1)
	enabled_events[index].execute_event(character, get_parent())
	events.erase(enabled_events[index])

func trigger_dungeon_event(character):
	$SpecificEvents/Dungeon.execute_event(character, get_parent())
