extends Node
var master_volume 
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# My quick checker function that looks for a key press. Once one occures then the seen will switch to main menu
func _input(event):
	if event is InputEventKey:
		# Switch scene to the mainMenu Fortniters.tscn
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://Scenes/Menu/Fortniters.tscn")

