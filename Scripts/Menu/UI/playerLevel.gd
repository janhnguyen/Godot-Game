extends Label

# Called every frame. 'delta' is the elapsed time since the previous frame.
# warning-ignore:unused_argument
func _process(delta):
	if (Globals.getPlayerLevel() < 10) :
		text = "0" + str(Globals.getPlayerLevel())
	else :
		text = str(Globals.getPlayerLevel())
