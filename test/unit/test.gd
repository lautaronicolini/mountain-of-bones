extends GutTest

var Char = load("res://frontend/character.tscn")
var _char = null
var _enemy = null

func before_each():
	_char = ArcherClass.new()
	_enemy = SoldierClass.new()
	_char.set_enemy(_enemy)

func test_assert_character_loots_4_gold():
	_char.loot_gold(4)
	assert_eq(_char.gold, 4, "Character should have 4 gold")

func test_assert_character_attacks_enemy_and_it_loses_life():
	var previous_life = _enemy.life_points
	_char.attack()
	assert_lt(_enemy.life_points, previous_life)

func test_assert_when_character_loots_item_new_action_added():
	var action_found = false
	var potion = PotionOfLife.new()
	_char.loot_item(potion)
	#actions.map de descripcion y revisar que esa lista contenga esta descripcion "Consumir Pocion"
	var actions = _char.get_actions()
	for action in actions:
		action_found = action.description == "Consumir Pocion"
	assert_true(action_found)

func test_assert_when_character_consumes_potion_gets_healed():
	var potion = PotionOfLife.new()
	_char.loot_item(potion)
	_char.receive_damage(10)
	var life_after_damage = _char.life_points
	_char.consume_item(_char.items[0])
	assert_lt(life_after_damage, _char.life_points)
