extends Node2D





func _on_PLAY_GAME_pressed() -> void:
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/Menu/NEWSCREEN.tscn")
	


func _on_CONTINUE_GAME_pressed() -> void:
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/Menu/NEWSCREEN.tscn")



func _on_SELECT_GAME_pressed() -> void:
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://SCenes/Menu/NEWSCREEN.tscn")
