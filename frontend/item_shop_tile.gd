extends Node2D

var item
var shop
var audio_player
@export var disabled = true
@onready var background_sprite = $TileBackground
const SHADER = preload("res://frontend/shaders/greyscale.gdshader")
var speed = 0
var label_equip_slot = ["Casco", "Armadura", "Arma"]
var label_class = ["Soldado", "Arquero"]

func _ready():
	var mat = ShaderMaterial.new()
	mat.set_shader(SHADER)
	background_sprite.set_material(mat)
	
func set_item(_item):
	item = _item
	set_price(item.price)
	set_image(item.image_path)
	set_tooltip_text(item.tooltip_description)
	if item.get_item_type() == BaseItem.ItemType.EQUIPABLE:
		$EquipSlot.set_text(label_equip_slot[item.equipment_slot])
		$Class.set_text(label_class[item.character_class])

func set_price(price):
	$PriceLabel.set_text("$%s" % price)
	
func set_image(image_path):
	$ItemImage.set_texture(load(image_path))

func set_tooltip_text(text):
	$Control.set_tooltip_text(text)

func set_price_label_red():
	$PriceLabel.set("theme_override_colors/font_color", Color.RED)

func _physics_process(delta):
	if disabled:
		$PriceLabel.set_text("")
		$ItemImage.set_texture(null)
		$Control.set_tooltip_text("")
		$EquipSlot.set_text("")
		$Class.set_text("")
		background_sprite.material.set_shader_parameter("on", true)

func _on_control_gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed and !disabled:
		if shop.sell(item):
			disabled = true
		else:
			audio_player.play()
