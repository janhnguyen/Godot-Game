extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
# Called when the node enters the scene tree for the first time.
func _ready():
	# Connect the "pressed" signal of the button to a method on this script
# warning-ignore:return_value_discarded
	connect("pressed", self, "_on_Button_pressed")

func _on_Button_pressed():
	# This function will be called when the button is pressed
	# Quit the game
	get_tree().quit()
