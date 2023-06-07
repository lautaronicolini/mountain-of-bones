extends Node2D

var item
var shop
var audio_player
@export var disabled = true
@onready var background_sprite = $TileBackground
const SHADER = preload("res://frontend/shaders/greyscale.gdshader")
var speed = 0

func _ready():
	var mat = ShaderMaterial.new()
	mat.set_shader(SHADER)
	background_sprite.set_material(mat)
	
func set_item(_item):
	item = _item
	set_price(item.price)
	set_image(item.image_path)
	set_tooltip_text(item.tooltip_description)

func set_price(price):
	$PriceLabel.set_text("$%s" % price)
	
func set_image(image_path):
	$ItemImage.set_texture(load(image_path))

func set_tooltip_text(text):
	$Control.set_tooltip_text(text)

func _physics_process(delta):
	if disabled:
		$PriceLabel.set_text("")
		$ItemImage.set_texture(null)
		$Control.set_tooltip_text("")
		background_sprite.material.set_shader_parameter("on", true)

func _on_control_gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed and !disabled:
		if shop.sell(item):
			disabled = true
		else:
			audio_player.play()
