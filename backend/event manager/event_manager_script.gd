extends Node2D

@onready var events = get_children()

func _on_trigger_random_event(character):
	var index = randi_range(0, events.size() -1)
	events[index].execute_event(character, get_parent())
	events.erase(events[index])
