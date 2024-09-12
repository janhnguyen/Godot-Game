extends HSlider





func _on_Brightnessslider_value_changed(value):
	GlobalWorldEnvironment.environment.adjustment_brightness = value
	pass # Replace with function body.
