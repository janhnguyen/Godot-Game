extends RichTextLabel

# Called every frame. 'delta' is the elapsed time since the previous frame.
# warning-ignore:unused_argument
func _process(delta):
	text = "HP - " + str(Globals.getPlayerHP())
