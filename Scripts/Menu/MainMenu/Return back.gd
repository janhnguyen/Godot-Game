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


func _on_Return_back_pressed():
	get_tree().change_scene("res://Scenes/Menu/Fortniters.tscn")
	pass # Replace with function body.


func _on_Return_back_button_down():
	$Buttonsound.play()
	pass # Replace with function body.
