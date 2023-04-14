extends Event

var damage = 1
var character

func _ready():
	type = "Slip on Ice"
	description = "Te patinas en el hielo,
	perdes una vida"

func execute_event(_character, scene_node):
	character = _character
	var option = create_option("Auch!", event_outcome)
	options_array = [option]
	scene_node.show_event_display_with_options(self)
	
func event_outcome():
	options_array[0].close_display()
	character.receive_damage(damage)
