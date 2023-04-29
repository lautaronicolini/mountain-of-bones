extends Control

var _action

func initialize(action):
	_action = action
	$Button.pressed.connect(execute_function)
	$Button.set_text(action.description)

func disable_button():
	$Button.disabled = true

func enable_button():
	$Button.disabled = false

func execute_function():
	_action.action_function.callv(_action.parameters)

func connect_to_press(function):
	$Button.pressed.connect(function)
