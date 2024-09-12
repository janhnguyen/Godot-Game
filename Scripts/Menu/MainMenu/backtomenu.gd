extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.





func _on_backtomenu_button_down():
	$Clicksound4.play()
	pass # Replace with function body.





func _on_backtomenu_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/Menu/Fortniters.tscn")
	pass # Replace with function body.
