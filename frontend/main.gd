extends Node2D

func pause_music():
	$AudioStreamPlayer2D.stop()

func play_music():
	$AudioStreamPlayer2D.play()
