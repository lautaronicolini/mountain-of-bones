extends ProgressBar

var character

func update_view():
	set_value(clamp(character.experience_points, 0, max_value))

func request_connect(_character):
	character = _character
	character.xp_updated.connect(update_view)
	max_value = character.xp_needed_by_level[character.level]
	set_value(character.experience_points)
