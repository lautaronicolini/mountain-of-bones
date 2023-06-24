extends GutTest

var Char = load("res://frontend/character.tscn")
var _char = null
var _enemy = null
var sword = Sword.new()
var crown = CrownOfFire.new()

func before_each():
	_char = SoldierClass.new()
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

func test_assert_character_buys_from_shop_potion_of_life():
	var action_found = false
	_char.loot_gold(100)
	var shop = Shop.new()
	shop.customer = _char
	shop.sell(PotionOfLife.new())
	var actions = _char.get_actions()
	for action in actions:
		action_found = action.description == "Consumir Pocion"
	assert_true(action_found)
	assert_lt(_char.gold, 100)

func test_assert_when_character_buys_from_shop_without_funds():
	var action_found = false
	_char.loot_gold(45)
	var shop = Shop.new()
	shop.customer = _char
	shop.sell(PotionOfLife.new())
	assert_eq(_char.gold, 45)

func test_assert_shop_has_stock():
	var shop = Shop.new()
	shop.add_stock(PotionOfLife.new())
	assert_eq(shop.stock.size(), 1)

func test_assert_when_character_equips_sword_its_attack_raises_by_one_and_item_leaves_inventory():
	var previous_strength = _char.get_strength()
	_char.loot_item(sword)
	_char.equip(sword)
	assert_eq(_char.get_strength(), previous_strength + 1)
	assert_does_not_have(_char.items, sword)

func test_assert_when_archer_class_character_tries_to_equip_sword_its_attack_stays_the_same_and_item_does_not_equip():
	var archer = ArcherClass.new()
	var previous_strength = archer.get_strength()
	archer.loot_item(sword)
	archer.equip(sword)
	assert_eq(archer.get_strength(), previous_strength)
	assert_null(archer.equiped_items[sword.equipment_slot])

func test_assert_when_character_equips_item_that_reduces_fire_damage_it_receives_less_damage_from_fire():
	_char.loot_item(crown)
	_char.equip(crown)
	var previous_life = _char.life_points
	_char.receive_damage(10, Character.damage_type.FIRE)
	assert_eq(_char.life_points, previous_life - 2)
	
