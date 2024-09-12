extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_backtomenu_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/Menu/Settings/settingsMenu.tscn")
	pass # Replace with function body.


func _on_backtomenu_button_down():
	$Clicksound4.play()
	pass # Replace with function body.
