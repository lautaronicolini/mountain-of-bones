extends Node2D

var boardview_scene = load("res://frontend/boardview.tscn").instantiate()

func _on_button_pressed():
	get_tree().get_root().add_child(boardview_scene)
	queue_free()
