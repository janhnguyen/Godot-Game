extends Node2D

func _on_okbutton_pressed():
	Globals.setPlayerName($TextureRect/LineEdit.text)
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/Levels/levelOne.tscn")

func _on_okbutton_button_down():
	$clicksound2.play()

func _on_BackButton_pressed():
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/Menu/Fortniters.tscn")

func _on_BackButton_button_down():
	$clicksound2.play()



func _on_instruction_button_down():
	$clicksound2.play()


func _on_instruction_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/Menu/mainMenu/instructionsPage.tscn")
	pass # Replace with function body.
