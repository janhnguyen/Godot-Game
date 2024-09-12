extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_Instruction_pressed():
	get_tree().change_scene("res://Scenes/Menu/Instructions page.tscn")
	pass # Replace with function body.


func _on_Instruction_button_down():
	$Clicksound6.play()
	pass # Replace with function body.
