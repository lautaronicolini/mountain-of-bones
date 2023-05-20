extends Node2D

func setup_tree(character):
	var tree = character.get_treat_tree()
	$RootNode.setup_node(tree[0][0], character)
	$RootNode.disable()
	$NodeChild1.setup_node(tree[1][0], character)
	$NodeChild2.setup_node(tree[1][1], character)
