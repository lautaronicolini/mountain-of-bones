extends Node

@onready var log_file_path = "user://log.txt"

func save(content):
	var file = FileAccess.open(log_file_path, FileAccess.READ_WRITE)
	file.seek_end()
	file.store_line(content)

func log(text):
	save("Log game information => " + text)

func flush():
	var file = FileAccess.open(log_file_path, FileAccess.WRITE)
	file.store_line("#### INICIO DE EJECUCIÓN ####")
