extends Node2D

var shop
var board_view

func _ready():
	get_tree().root.get_node("Game").pause_music()
	
func set_shop(_shop):
	shop = _shop
	update_gold_ui()
	shop.customer.gold_updated.connect(update_gold_ui)
	for item_display in $ItemDisplays.get_children():
		item_display.shop = shop
		item_display.audio_player = $ButtonErrorStreamPlayer
	var index = 0
	for item in shop.stock:
		$ItemDisplays.get_children()[index].disabled = false
		$ItemDisplays.get_children()[index].set_item(item)
		index += 1
	validate_funds()

func _on_button_pressed():
	board_view.enable_start_camera()
	board_view.get_node("GUI").show()
	get_tree().root.get_node("Game").play_music()
	queue_free()

func set_shop_text(text):
	$Label.set_text(text)

func update_gold_ui():
	$Gold.set_text("Tu oro: %s" % shop.customer.gold)
	validate_funds()

func validate_funds():
	var index = 0
	for item in shop.stock:
		if shop.customer.gold < item.price:
			$ItemDisplays.get_children()[index].set_price_label_red()
		index += 1
