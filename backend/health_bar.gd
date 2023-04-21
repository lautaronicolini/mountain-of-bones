extends Control

@export var character:Node2D
var max_value

func _ready():
	character.damage_received.connect(update_view)
	max_value = character.max_life_points
	
func update_view():
	$ProgressBar.set_value(character.life_points * 100 / max_value)
