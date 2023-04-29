extends Control

signal character_chosen

@onready var mp_label = $ChMove
@onready var lp_label = $ChLife
@onready var sprite = $ChSpriteHolder/Sprite2D
@onready var character

func set_character(ch):
	character = ch
	mp_label.set_text(str(ch.character.movement_points))
	lp_label.set_text(str(ch.character.life_points))
	sprite.set_texture(load(ch.character.sprite_path))

func _on_ch_select_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		get_parent().get_parent()._on_character_select_character_chosen(character)
		get_parent().queue_free()
