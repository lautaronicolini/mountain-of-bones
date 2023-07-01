extends Control

var character
@onready var logger = $Logger

func set_character(_character):
	character = _character
	character.damage_received.connect(update_life_gui)
	character.healed.connect(update_life_gui)
	character.gold_updated.connect(update_gold_gui)
	get_node("ExperienceBar").request_connect(character)
	get_node("Inventory").set_character(character)
	character.leveled_up.connect(show_treat_tree)
	update_life_gui()
	update_gold_gui()

func update_life_gui():
	logger.log("Vida del personaje: " + str(character.life_points))
	$LifeLabel.set_text(str(character.life_points))
	
func update_gold_gui():
	logger.log("Oro del personaje: " + str(character.gold))
	$GoldLabel.set_text(str(character.gold))

func show_treat_tree():
	LevelUpEvent.new().execute_event(character, self)

func restart_game():
	var intro = load("res://frontend/intro.tscn").instantiate()
	intro.set_scale(Vector2(1.645, 1.645))
	for child in get_tree().get_root().get_children():
		if child != get_node("/root/Game"):
			child.queue_free()
	get_tree().get_root().add_child(intro)
	queue_free()

func _on_reiniciar_pressed():
	restart_game()

func _on_equipamiento_pressed():
	$EquipmentMenu.set_character(character)
	$EquipmentMenu.show()
