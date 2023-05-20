extends Node2D

var player = load("res://frontend/character.tscn").instantiate()
var enemy = load("res://frontend/character.tscn").instantiate()
var disabled = true

signal player_won
signal enemy_won

func set_battle(character):
	add_child(player)
	player.set_position(Vector2(-172,262))
	player.scale = Vector2(6, 6)
	var potion = PotionOfLife.new()
	character.loot_item(potion)
	player.set_character(character)
	player.connect_action_animations()
	player.connect_item_animations()
	add_child(enemy)
	enemy.set_position(Vector2(170,262))
	enemy.scale = Vector2(-6, 6)
	enemy.set_character(SoldierClass.new())
	enemy.connect_action_animations()
	player.set_sprite()
	enemy.set_sprite()

	player = player.character
	enemy = enemy.character
	player.set_enemy(enemy)
	enemy.set_enemy(player)
	player.dead.connect(func () : 
		queue_free()
		emit_signal("enemy_won"))
	enemy.dead.connect(func () : 
		queue_free()
		player.current_display = get_node("/root/BoardViewScene/Path2D/PathFollow2D").character_scene
		emit_signal("player_won"))
	$HealthBar.request_connect(player)
	$HealthBar2.request_connect(enemy)
	load_actions()
	disabled = false

func start_enemy_attack_timer():
	for action in $ActionContainer.get_children():
		action.disable_button()
	$DisableActionsTimer.start()

func _on_timer_timeout():
	var attack = enemy.actions[0]
	attack.emit_signal("execute_action", attack)
	attack.action_function.callv(attack.parameters)
	for action in $ActionContainer.get_children():
		action.enable_button()

func load_actions():
	for action in player.get_actions():
		var action_display = load("res://frontend/action.tscn").instantiate()
		action_display.initialize(action)
		action_display.connect_to_press(start_enemy_attack_timer)
		$ActionContainer.add_child(action_display)

func _physics_process(_delta):
	if !disabled:
		if $ActionContainer.get_children().size() != player.get_actions().size():
			for child in $ActionContainer.get_children():
				child.queue_free()
			load_actions()
