extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var master_bus= AudioServer.get_bus_index("Master")


func _on_HSlider_value_changed(value):
	Globals.set_global_volume(value)
	AudioServer.set_bus_volume_db(master_bus, value)
	
	if value == -30:
		AudioServer.set_bus_mute(master_bus, value <= -30)
	else:
		AudioServer.set_bus_mute(master_bus, false)
	


func _on_backtomenu2_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/Menu/Settings-PauseMenu/settingsMenu2.tscn")
	pass # Replace with function body.


func _on_backtomenu2_button_down():
	$SettingsMenu/Clicksound2.play()
	pass # Replace with function body.
