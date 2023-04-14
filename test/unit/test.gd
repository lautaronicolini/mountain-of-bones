extends GutTest

var Char = load("res://frontend/character.tscn")
var _char = null

func before_each():
	_char = Char.instantiate()

func test_assert_character_loots_4_gold():
	_char.loot_gold(4)
	assert_eq(_char.gold, 4)
