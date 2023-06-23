extends Event

var character
var main_scene

func _ready():
	type = "Shop Encounter"
	description = "Al avanzar por la montaña, ves, para tu
	sorpresa, una puerta extraña insertada en
	 la pared rocosa. El felpudo tiene una 
	inscripcion de bienvenida y el calor
	dentro del recinto te incita a entrar."

func execute_event(_character, scene_node):
	main_scene = scene_node
	character = _character
	var option_0 = create_option("Entrar", trigger_shop_scene)
	options_array.append(option_0)
	scene_node.show_event_display_with_options(self)

func trigger_shop_scene():
	var shop_scene = load("res://frontend/shop.tscn").instantiate()
	var shop = Shop.new()
	shop.customer = character
	shop.stock = [PotionOfLife.new(), Sword.new(), Bow.new(), Axe.new()]
	shop_scene.set_shop(shop)
	shop_scene.board_view = main_scene
	get_tree().root.add_child(shop_scene, 0)
	options_array[0].close_display()
	main_scene.disable_start_camera()
