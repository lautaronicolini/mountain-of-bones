extends PathFollow2D

@export var _speed = 0
@onready var _character = $Character

func set_character(character):
	_character.queue_free()
	_character = character
	add_child(character, 0)
	return true

func _physics_process(delta):
	set_progress(get_progress() + _speed * delta)
