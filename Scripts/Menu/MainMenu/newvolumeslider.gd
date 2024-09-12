extends HSlider


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var master_bus= AudioServer.get_bus_index("Master")




func _on_HSlider_value_changed(value):
	Globals.set_global_volume(value)
	AudioServer.set_bus_volume_db(master_bus, value)
	
	if value == -30:
		AudioServer.set_bus_mute(master_bus, value <= -30)
	else:
		AudioServer.set_bus_mute(master_bus, false)
	
