extends Sprite2D

var treat
var character

func setup_node(_treat, _character):
	treat = _treat
	character = _character
	$Sprite2D.set_texture(load(treat.treat_image_path))
	$Control.set_tooltip_text(treat.treat_tooltip)

func disable():
	$Control.visible = false

func _on_control_gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		treat.apply_treat(character)
		get_parent().queue_free()
