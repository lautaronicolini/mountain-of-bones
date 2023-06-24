extends Node

class_name Shop

var stock = []
var customer

func add_stock(item):
	stock.append(item)

func sell(item):
	if item.is_valid_trade(customer):
		customer.lose_gold(item.price)
		customer.loot_item(item)
		return true
	else:
		return false
