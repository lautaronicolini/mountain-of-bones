extends Node2D

var shop

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

func _on_button_pressed():
	queue_free()

func update_gold_ui():
	$Gold.set_text("Tu oro: %s" % shop.customer.gold)
