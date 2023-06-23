extends Area2D

@export var _passed = false
signal trigger_random_event
signal trigger_dungeon_event

func mark_as_passed():
	_passed = true

func has_been_passed():
	return _passed

func spawn_event(character):
	emit_signal("trigger_random_event", character)

func spawn_dungeon_event(character):
	emit_signal("trigger_dungeon_event", character)
