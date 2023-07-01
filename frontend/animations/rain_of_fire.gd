extends Node2D

var disabled = true

signal animation_completed

func _ready():
	$GPUParticles2D.emitting = true
	$AudioStreamPlayer2D.play()
	$StopSpawn.start()

func _on_stop_spawn_timeout():
	$GPUParticles2D.emitting = false
	$DetachTimer.start()

func _on_detach_timer_timeout():
	emit_signal("animation_completed")
	queue_free()
