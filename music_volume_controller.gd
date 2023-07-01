extends Node2D

var on = false
var music_index

func _ready():
	music_index = AudioServer.get_bus_index("Music")
	var start_value = AudioServer.get_bus_volume_db(music_index)
	$VSlider.set_value_no_signal(db_to_linear(start_value))

func _on_control_gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		on = !on
		$VSlider.visible = on
		$Sprite2D.material.set_shader_parameter("on", on)

func _on_v_slider_value_changed(value):
	AudioServer.set_bus_volume_db(music_index, linear_to_db(value))
