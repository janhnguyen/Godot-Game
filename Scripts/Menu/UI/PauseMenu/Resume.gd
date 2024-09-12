extends Button

# Signal declaration
signal resume_pressed

func _ready():
# warning-ignore:return_value_discarded
	self.connect("pressed", self, "_on_Resume_pressed")

func _on_Resume_pressed():
	emit_signal("resume_pressed")
	# This method will be called when the button is pressed
	# Change to the target scene
	#get_tree().change_scene(pause_menu)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
