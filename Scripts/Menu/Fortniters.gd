extends Control

func _on_Instruction_button_pressed():
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/Menu/mainMenu/instructionsPage.tscn")

func _on_Instruction_button_button_down():
	$Clicksound6.play()
