extends Node2D

var character
@onready var sprite = $Path2D/PathFollow2D/Sprite2D
const SHADER = preload("res://frontend/shaders/damaged.gdshader")
var speed = 0

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

func connect_item_animations():
	character.item_consumed.connect(item_animation)

func connect_action_animations():
	for action in character.get_actions():
		action.execute_action.connect(action_animation)

func got_damaged():
	sprite.material.set_shader_parameter("on", true)
	$DamageAnimationTimer.start()

func action_animation(action):
	action.apply_animation(self)
	
func item_animation(item):
	item.animation_effect(self)

#GENERAR METODO PARAMETRIZABLE PARA ESTOS CASOS
func ray_of_light():
	var ray = load("res://frontend/animations/retractile_ray.tscn").instantiate()
	add_child(ray)
	ray.set_position($RayEffectSpawnPoint.get_position())
	ray.disabled = false
	
func raise_shield():
	var shield = load("res://frontend/animations/raise_shield.tscn").instantiate()
	add_child(shield)
	shield.set_position($ShieldSpawnPoint.get_position())
	shield.disabled = false
	
func shoot_arrow():
	var arrow = load("res://frontend/animations/Arrow.tscn").instantiate()
	arrow.set_position($ArrowSpawnPoint.get_position())
	add_child(arrow)
#########

func _on_timer_timeout():
	sprite.material.set_shader_parameter("on", false)

func attack_movement():
	speed = 250

func _physics_process(delta):
	$Path2D/PathFollow2D.set_progress(clamp($Path2D/PathFollow2D.get_progress() + speed * delta, 0, 9999))
	if $Path2D/PathFollow2D.get_progress_ratio() >= 1:
		speed = -500
	elif $Path2D/PathFollow2D.get_progress_ratio() == 0:
		speed = 0
