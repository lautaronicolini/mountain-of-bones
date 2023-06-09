extends Control

var character
var max_value

signal empty

func update_view():
	$ProgressBar.set_value(character.life_points * 100 / max_value)
	if character.life_points <= 0:
		emit_signal("empty")

func request_connect(_character):
	character = _character
	character.damage_received.connect(update_view)
	character.healed.connect(update_view)
	max_value = character.get_max_life()
	$ProgressBar.set_value(character.life_points * 100 / max_value)
