extends Button

var _action

func initialize(action):
	_action = action
	pressed.connect(execute_function)
	set_button_icon(load(action.icon_path))
	set_tooltip_text(action.tooltip_description)

func disable_button():
	disabled = true

func enable_button():
	disabled = false

func execute_function():
	_action.emit_signal("execute_action", _action)
	
func connect_to_press(function):
	pressed.connect(function)
