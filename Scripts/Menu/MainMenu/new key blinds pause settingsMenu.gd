extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_backtomenu2_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/Menu/Settings-PauseMenu/settingsMenu2.tscn")
	pass # Replace with function body.


func _on_backtomenu2_button_down():
	$SettingsMenu/Clicksound4.play()
	pass # Replace with function body.
