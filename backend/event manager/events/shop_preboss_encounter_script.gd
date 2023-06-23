extends Event

var character
var main_scene

func _ready():
	type = "Pre Boss Shop Encounter"
	description = "Al avanzar por la cueva, ves, la
	puerta de una extraña tienda. El felpudo tiene una 
	inscripcion de bienvenida y el calor
	dentro del recinto te incita a entrar."

func execute_event(_character, scene_node):
	main_scene = scene_node
	character = _character
	var option_0 = create_option("Entrar", trigger_shop_scene)
	options_array.append(option_0)
	show_event_display_with_options(scene_node)

func trigger_shop_scene():
	var shop_scene = load("res://frontend/shop.tscn").instantiate()
	var shop = Shop.new()
	shop.customer = character
	shop.stock = [PotionOfLife.new(), Sword.new(), Bow.new(), Axe.new()]
	shop_scene.set_shop_text("Delante te espera un enemigo muy poderoso, te 
	recomiendo llevar este item de protección contra el fuego.
	Te lo dejo con descuento.")
	shop_scene.set_shop(shop)
	shop_scene.board_view = main_scene
	get_tree().root.add_child(shop_scene, 0)
	options_array[0].close_display()
	main_scene.disable_start_camera()
