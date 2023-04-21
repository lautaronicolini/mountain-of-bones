extends Node2D

var damaged = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Character.get_actions()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !damaged:
		damaged = true
		$Character.receive_damage(4)
