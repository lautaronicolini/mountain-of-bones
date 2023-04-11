extends Node2D

var label_text = ""
signal option_1_chosen

func set_label_text(text):
	label_text = text

func _ready():
	$Label.set_text(label_text)

func _on_area_2d_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		emit_signal("option_1_chosen")
		get_parent().close_display()
