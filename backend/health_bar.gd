extends Control

var character
var max_value

func update_view():
	$ProgressBar.set_value(character.life_points * 100 / max_value)

func request_connect(_character):
	character = _character
	character.damage_received.connect(update_view)
	character.healed.connect(update_view)
	max_value = character.max_life
	$ProgressBar.set_value(character.life_points * 100 / max_value)
