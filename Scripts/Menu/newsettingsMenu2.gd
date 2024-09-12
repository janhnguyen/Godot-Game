extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"





	


func _on_toVol_button_down():
	$SettingsMenu/Clicksound2.play()
	pass # Replace with function body.


func _on_toVol_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/Menu/Settings-PauseMenu/new volume pause settingsMenu.tscn")
	pass # Replace with function body.





func _on_toKeys_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/Menu/Settings-PauseMenu/new key blinds pause settingsMenu.tscn")
	pass # Replace with function body.


func _on_toKeys_button_down():
	$SettingsMenu/Clicksound2.play()
	pass # Replace with function body.
