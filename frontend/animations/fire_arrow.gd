extends Node2D

var speed = 100
var velocity = Vector2()
var disabled = true

signal animation_completed

func _ready():
	velocity.x = 1
	velocity = velocity.normalized() * speed
	$AudioStreamPlayer2D.play()

func _physics_process(delta):
	if !disabled:
		position += velocity * delta

func _on_area_2d_body_entered(body):
	emit_signal("animation_completed")
	queue_free()
