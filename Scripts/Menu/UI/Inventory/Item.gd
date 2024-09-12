extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if randi() % 4 ==  0 :
		$TextureRect.texture = load("res://Art/UIElements/rock.png")
	else :
		$TextureRect.texture = load("res://Art/UIElements/stick.png")

