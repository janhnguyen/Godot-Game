extends HSlider


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var master_bus= AudioServer.get_bus_index("Master")
# Called when the node enters the scene tree for the first time.
func _ready():
	var slider = $CanvasLayer/HSlider  # Adjust the path to match your slider's NodePath
	slider.value = Globals.get_global_volume()
	# Update the in-game volume to match the initial global volume
	_on_HSlider_value_changed(slider.value)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_HSlider_value_changed(value):
	Globals.set_global_volume(value)
	AudioServer.set_bus_volume_db(master_bus, value)
	
	if value == -30:
		AudioServer.set_bus_mute(master_bus, value <= -30)
	else:
		AudioServer.set_bus_mute(master_bus, false)

	pass # Replace with function body.
