extends TextureProgress

func _ready():
	# Set initial HP
	set_hp(100)

func set_hp(new_hp):
	# Clamp the HP value between 0 and max_value
	var clamped_hp = clamp(new_hp, 0, max_value)
	
	# Set the new HP value
	set_value(clamped_hp)
