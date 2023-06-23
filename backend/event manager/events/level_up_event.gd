extends Event

class_name LevelUpEvent

func execute_event(_character, _scene_node):
	var treat_tree_scene = load("res://frontend/treat_tree_display.tscn").instantiate()
	treat_tree_scene.setup_tree(_character)	
	treat_tree_scene.set_scale(Vector2(0.3,0.3))
	treat_tree_scene.set_z_index(1)
	_scene_node.add_child(treat_tree_scene, 0)
