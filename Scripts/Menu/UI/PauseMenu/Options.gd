extends Button

func _ready():
	# Connect the "pressed" signal of the button to the "_on_OptionsButton_pressed" method
# warning-ignore:return_value_discarded
	connect("pressed", self, "_on_OptionsButton_pressed")

func _on_OptionsButton_pressed():
	# Change to the SettingsMenu scene when the button is pressed //  duplicate the settings menu
# warning-ignore:return_value_discarded

	#var settings_scene = load("res://Scenes/Menu/Settings-PauseMenu/settingsMenu2.tscn").instance()
	#add_child(settings_scene)
	 SceneManager.switch_scene("res://Scenes/Menu/Settings-PauseMenu/settingsMenu2.tscn")
	

