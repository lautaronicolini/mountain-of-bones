extends Node2D

var player = load("res://frontend/character.tscn").instantiate()
var enemy = load("res://frontend/character.tscn").instantiate()
var disabled = true
var previous_display
var final_boss_bg = false

var noise_i = 0.0
var shake_strength = 0.0
var noise = FastNoiseLite.new()
@export var RANDOM_SHAKE_STRENGTH = 30.0
@export var SHAKE_DECAY_RATE = 5.0
@export var NOISE_SHAKE_SPEED = 0.0
@export var NOISE_SHAKE_STRENGTH = 60.0

signal player_won
signal enemy_won

func _ready():
	$Camera2D.enabled = true
	get_node("/root/Game").pause_music()
	$Music.play()
	if final_boss_bg:
		$FinalBossBG.show()

func set_battle(character, oponent):
	previous_display = character.current_display
	add_child(player)
	player.set_position(Vector2(-172,262))
	player.scale = Vector2(6, 6)
	player.set_character(character)
	player.connect_action_animations()
	add_child(enemy)
	enemy.set_position(Vector2(170,262))
	enemy.scale = Vector2(-6, 6)
	enemy.set_character(oponent)
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
		player.current_display = previous_display
		player.current_display.disable_collition_monitoring()
		$Timer.timeout.connect(func():emit_signal("enemy_won"))
		$Timer.start()
		close_view())
	$HealthBar2.empty.connect(func () : 
		player.current_display = previous_display
		player.current_display.disable_collition_monitoring()
		$AudioStreamPlayer2D.play()
		$Timer.start()
		$DisableActionsTimer.stop()
		close_view())
	$HealthBar.request_connect(player)
	$HealthBar2.request_connect(enemy)
	$ShieldBar.request_connect(player)
	load_actions()
	disabled = false

func start_enemy_attack_timer():
	enemy.current_display.disable_collition_monitoring()
	disable_actions()
	$DisableActionsTimer.start()

func _on_timer_timeout():
	enemy.current_display.enable_collition_monitoring()
	enemy.enemy_action()
	enable_actions()

func load_actions():
	for action in player.get_actions():
		var action_display = load("res://frontend/action.tscn").instantiate()
		action_display.initialize(action)
		action_display.connect_to_press(start_enemy_attack_timer)
		action_display.scale = Vector2(0.3,0.3)
		$ActionContainer.add_child(action_display)

func _physics_process(delta):
	if !disabled:
		if $ActionContainer.get_children().size() != player.get_actions().size():
			for child in $ActionContainer.get_children():
				child.queue_free()
			load_actions()
			disable_actions()
	shake_strength = lerp(shake_strength, NOISE_SHAKE_SPEED, SHAKE_DECAY_RATE * delta)
	$Camera2D.offset = get_noise_offset(delta)

func _on_music_timer_timeout():
	emit_signal("player_won")

func disable_actions():
	for action in $ActionContainer.get_children():
		action.disable_button()

func enable_actions():
	for action in $ActionContainer.get_children():
		action.enable_button()

func close_view():
	$Music.stop()
	get_node("/root/Game").play_music()

func start_shaking():
	NOISE_SHAKE_SPEED = 30.0
	$ShakeTimer.start()

func get_noise_offset(delta):
	noise_i += delta * NOISE_SHAKE_SPEED
	return Vector2(
		noise.get_noise_2d(100, noise_i) * shake_strength,
		noise.get_noise_2d(1, noise_i) * shake_strength,
	)

func _on_shake_timer_timeout():
	NOISE_SHAKE_SPEED = 0.0
	enemy.enemy_action()
