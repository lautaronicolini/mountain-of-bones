extends Node2D

@onready var shield = $Sprite2D
var speed = 0.05
var disabled = true

func _physics_process(delta):
	var position_y = shield.get_position()[1]
	if position_y > -12 && !disabled:
		shield.set_position(Vector2(0,position_y - speed))
		speed += 0.1
		if shield.get_position()[1] <= -12:
			$Timer.start()

func _on_timer_timeout():
	queue_free()
