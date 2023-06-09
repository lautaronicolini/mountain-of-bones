extends Control

var character

func update_view():
	if character.defense > $ProgressBar.get_max():
		$ProgressBar.set_max(character.defense)
	var text = "%s / %s" % [character.defense, $ProgressBar.get_max()]
	$Label.set_text(text)
	$ProgressBar.set_value(character.defense)
	if character.defense == 0:
		$Timer.start()
	else:
		visible = true

func request_connect(_character):
	character = _character
	character.damage_received.connect(update_view)
	character.shield_raised.connect(update_view)
	$ProgressBar.set_value(character.defense)
	$ProgressBar.set_max(character.defense)


func _on_timer_timeout():
	visible = false
