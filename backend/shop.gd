extends Node

class_name Shop

var stock = []
var customer

func add_stock(item):
	stock.append(item)

func sell(item):
	if customer.gold < item.price:
		return false
	else:
		customer.lose_gold(item.price)
		customer.loot_item(item)
		return true
