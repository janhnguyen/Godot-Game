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
	# Change the current scene to the newly loaded scene
# warning-ignore:return_value_discarded # You need to implement get_current_overlay
	 SceneManager.switch_scene("res://Scenes/Menu/Settings-PauseMenu/brightness2.tscn")



func _on_toBright_button_down():
	$Clicksound1.play()
	pass # Replace with function body.
