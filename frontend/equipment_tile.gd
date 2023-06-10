extends Sprite2D

var item
var selected = false
@onready var current_position = get_position()
var label_type = ["Casco", "Armadura", "Arma"]

func set_item(_item):
	item = _item
	$ItemSprite.set_texture(load(item.image_path))
	$Type.set_text(label_type[item.equipment_slot])

func _on_area_2d_input_event(viewport, event, shape_idx):
	if !Input.is_action_pressed("click"):
		selected = false
	else:
		selected = true

func _on_area_2d_area_entered(area):
	area.get_parent().set_item(item)

func _physics_process(delta):
	if selected:
		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)
	else:
		set_position(current_position)
