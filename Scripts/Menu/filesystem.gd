extends Node


func save_game(file_name):
	var file = $LineEdit.text
	file.open("res://Scenes/Levels/levelOne.tscn")
	
	file.close()
