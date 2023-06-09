extends Node2D

var character
@onready var sprite = $Path2D/PathFollow2D/Sprite2D
const SHADER = preload("res://frontend/shaders/damaged.gdshader")
var speed = 0
var current_action

signal animation_completed

func _ready():
	var mat = ShaderMaterial.new()
	mat.set_shader(SHADER)
	sprite.set_material(mat)

func set_sprite():
	$Path2D/PathFollow2D/Sprite2D.set_texture(load(character.sprite_path))

func set_character(_character):
	character = _character
	character.damage_received.connect(got_damaged)
	character.current_display = self

func connect_action_animations():
	for action in character.get_actions():
		action.execute_action.connect(action_animation)

func got_damaged():
	sprite.material.set_shader_parameter("on", true)
	$DamageAnimationTimer.start()

func action_animation(action):
	action.apply_animation(self)
	
func item_animation(item):
	var animation = load(item.animation_path).instantiate()
	animation.set_position(get_node(item.spawn_point).get_position())
	animation.animation_completed.connect(func () :
		character.consume_item(item))
	add_child(animation)
	animation.disabled = false

func play_animation(animation_path, spawn_point, action):
	var animation = load(animation_path).instantiate()
	animation.set_position(get_node(spawn_point).get_position())
	animation.animation_completed.connect(func () :
		action.action_function.callv(action.parameters))
	add_child(animation)
	animation.disabled = false

func _on_timer_timeout():
	sprite.material.set_shader_parameter("on", false)

func attack_movement(action):
	speed = 200
	current_action = action
	animation_completed.connect(run_action)

func _physics_process(delta):
	$Path2D/PathFollow2D.set_progress(clamp($Path2D/PathFollow2D.get_progress() + speed * delta, 0, 9999))
	if $Path2D/PathFollow2D.get_progress_ratio() >= 1:
		speed = -500
	elif $Path2D/PathFollow2D.get_progress_ratio() == 0:
		speed = 0

func _on_area_2d_body_entered(body):
	emit_signal("animation_completed")
	$AudioStreamPlayer2D.play()

func run_action():
	current_action.action_function.callv(current_action.parameters)
	animation_completed.disconnect(run_action)

func disable_collition_monitoring():
	$Path2D/PathFollow2D/Area2D.monitoring = false

func enable_collition_monitoring():
	$Path2D/PathFollow2D/Area2D.monitoring = true
