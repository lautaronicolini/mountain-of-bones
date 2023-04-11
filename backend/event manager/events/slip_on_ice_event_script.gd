extends Event

var damage = 1
var character

func _ready():
	description = "Te patinas en el hielo,
	perdes una vidas"

func execute_event(_character, scene_node):
	character = _character
	var option = load(option_scene)
	option = option.instantiate()
	option.set_label_text("Auch!")
	option.option_1_chosen.connect(event_outcome)
	var options_array = [option]
	scene_node.show_event_display_with_options(options_array, description)
	
func event_outcome():
	character.receive_damage(damage)
