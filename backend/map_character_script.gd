extends PathFollow2D

@export var _speed = 0
@onready var character_scene = $Character
@onready var collition_area = $CollitionCharacter
@onready var disabled = true

func set_character(character):
	character_scene.queue_free()
	character_scene = character
	add_child(character, 0)
	return true

func toggle_movement():
	disabled = !disabled

func _physics_process(delta):
	if !disabled:
		set_progress(get_progress() + _speed * delta)
		if !collition_area.get_overlapping_areas().is_empty():
			var collitioned_tile = collition_area.get_overlapping_areas()[0]
			if !collitioned_tile.has_been_passed():
				collitioned_tile.mark_as_passed()
				character_scene.character.update_post_movement()
				if character_scene.character.current_tile >= 4:
					character_scene.character.emit_signal("out_of_sight")
				elif character_scene.character._movement_points_left == 0:
					character_scene.character.logger.log("Casillero actual: " + str(character_scene.character.current_tile))
					collitioned_tile.spawn_event(character_scene.character)
					_speed = 0
					character_scene.character.reset_move_points()
