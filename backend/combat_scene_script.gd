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
	player.set_character(character)
	player.connect_action_animations()
	add_child(enemy)
	enemy.set_position(Vector2(170,262))
	enemy.scale = Vector2(-6, 6)
	enemy.set_character(SoldierClass.new())
	enemy.connect_action_animations()
	player.set_sprite()
	enemy.set_sprite()
	player.enable_collition_monitoring()
	enemy.disable_collition_monitoring()
	
	player = player.character
	enemy = enemy.character
	player.set_enemy(enemy)
	enemy.set_enemy(player)
	$HealthBar.empty.connect(func () : 
		emit_signal("enemy_won"))
	$HealthBar2.empty.connect(func () : 
		player.current_display = get_node("/root/BoardViewScene/Path2D/PathFollow2D").character_scene
		player.current_display.disable_collition_monitoring()
		$AudioStreamPlayer2D.play()
		$Timer.start()
		$DisableActionsTimer.stop())
	$HealthBar.request_connect(player)
	$HealthBar2.request_connect(enemy)
	$ShieldBar.request_connect(player)
	load_actions()
	disabled = false

func start_enemy_attack_timer():
	enemy.current_display.disable_collition_monitoring()
	for action in $ActionContainer.get_children():
		action.disable_button()
	$DisableActionsTimer.start()

func _on_timer_timeout():
	enemy.current_display.enable_collition_monitoring()
	var attack = enemy.actions[0]
	attack.emit_signal("execute_action", attack)
	for action in $ActionContainer.get_children():
		action.enable_button()

func load_actions():
	for action in player.get_actions():
		var action_display = load("res://frontend/action.tscn").instantiate()
		action_display.initialize(action)
		action_display.connect_to_press(start_enemy_attack_timer)
		action_display.scale = Vector2(0.3,0.3)
		$ActionContainer.add_child(action_display)

func _physics_process(_delta):
	if !disabled:
		if $ActionContainer.get_children().size() != player.get_actions().size():
			for child in $ActionContainer.get_children():
				child.queue_free()
			load_actions()


func _on_music_timer_timeout():
	emit_signal("player_won")
