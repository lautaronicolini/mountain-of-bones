extends Node2D

@onready var ray = $ColorRect
var speed = 10
var disabled = true

func _physics_process(delta):
	if ray.get_size()[1] <= 38 && !disabled:
		ray.set_size(Vector2(17,speed))
		speed += 3
		if ray.get_size()[1] >= 38:
			$Timer.start()

func _on_timer_timeout():
	queue_free()
