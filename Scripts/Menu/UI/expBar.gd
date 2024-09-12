extends TextureProgress

func _ready():
	# Set initial EXP
	set_exp(0)

func set_exp(new_exp):
	# Clamp the EXP value between 0 and max_value
	var clamped_exp = clamp(new_exp, 0, max_value)
	
	# Set the new EXP value
	set_value(clamped_exp)
