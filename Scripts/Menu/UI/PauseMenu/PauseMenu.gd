extends Control
signal options_pressed
onready var pause_menu = $PauseMenu
var paused = false

# Called when the node enters the scene tree for the first time.
#Pause button
func _ready():
	$OptionsButton.connect("pressed", self, "_on_OptionsButton_pressed")
	
func _process(delta):
	if Input.is_action_just_pressed('pause'):
		pauseMenu()

func pauseMenu():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
		
	paused = !paused
	
func _on_OptionsButton_pressed():
	# Load the Settings scene
	emit_signal("settings_button_pressed")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
