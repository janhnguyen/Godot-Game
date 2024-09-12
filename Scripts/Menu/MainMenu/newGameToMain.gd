extends Button

# Called when the node enters the scene tree for the first time.
func _ready():
	# Connect the button's "pressed" signal to the function that handles the click event
# warning-ignore:return_value_discarded
	connect("pressed", self, "_on_button_pressed")

func _on_button_pressed() -> void:
	# Change the current scene to the newly loaded scene
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/Menu/Fortniters.tscn")




func _on_newGameToMain_mouse_entered():
	$Clicksound.play()
	pass # Replace with function body.
