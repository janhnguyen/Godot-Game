extends Node2D

func _on_Button_pressed():
	Globals.setPlayerLevel(1 + Globals.getPlayerLevel())
