extends Node2D

var speed = 150
var velocity = Vector2()

func _ready():
	velocity.x = 1
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	position += velocity * delta

func _on_area_2d_body_entered(body):
	queue_free()
