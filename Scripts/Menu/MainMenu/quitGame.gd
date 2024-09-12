extends Button

# Called when the node enters the scene tree for the first time.
func _ready():
	# Connect the button's "pressed" signal to the function that handles the click event
# warning-ignore:return_value_discarded
	connect("pressed", self, "_on_button_pressed")

func _on_button_pressed() -> void:
	# Exits the game
	get_tree().quit()

func _on_quitGame_button_down():
	$Clicksound5.play()
	pass # Replace with function body.
