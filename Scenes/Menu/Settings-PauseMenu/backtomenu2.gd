extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	# Connect the button's "pressed" signal to the function that handles the click event
# warning-ignore:return_value_discarded
	connect("pressed", self, "_on_button_pressed")
	
func _on_button_pressed() -> void:
	get_parent().get_parent().queue_free()
	print("Button pressed")





func _on_backtomenu2_button_down():
	$Clicksound4.play()
	pass # Replace with function body.
