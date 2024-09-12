extends Area2D

# Declare member variables here. Examples:

var defense = Globals.getPlayerDefense()
var health = Globals.getPlayerHP()
#onready var playerNode = get_parent().get_child(4)

#func _on_ShieldItem_body_entered(body):
	#if ("player" in str(body)) : # Ensure it's the player that touches the item
	#	defense= defense+25
	#	Globals.setPlayerDefense(defense) 
	#	print(defense)
		#queue_free()  # Remove the item from the scene
	#	position = Vector2(-1000, -1000)  # Make the node invisible
		#queue_free()
		#$CollisionShape2D.disabled = true

#combat variables

var timer
	
func _ready():
	# Initialize the timer here to avoid repeated creation
	#timer = Timer.new()=
	timer = Timer.new()
	timer.one_shot = true
	add_child(timer)
	timer.connect("timeout", self, "_on_Timer_timeout")
	
	
	
#fix this garbage later


func _on_ShieldItem_body_entered(body):
	var item= Globals.getItem()
# warning-ignore:shadowed_variable
	var health = Globals.getPlayerHP()
# warning-ignore:shadowed_variable
	var defense = Globals.getPlayerDefense()
	#print(item)
	if ("player" in str(body)) and item == 1 : # Ensure it's the player that touches the item
		defense= defense+5
		Globals.setPlayerDefense(defense) 
		print(health)
		print(defense)
		if(Globals.getItem()!= 0):
		 # Remove the item from the scene
			#var camera = get_viewport().get_camera()
			#var camera_position = camera.global_position
			#$Label.visible = true
			#$CanvasLayer/Label.rect_position = camera_position
			$CanvasLayer/Label.text = "Gained 5 Armor!"
			$CanvasLayer/Label.visible = true
			
			timer.wait_time = 3.0 
			timer.start()
		
		
		position = Vector2(-1000, -1000)  # Make the node invisibl
		Globals.setItem(0)
		
func _on_Timer_timeout():
	$CanvasLayer/Label.visible = false
		#queue_free()  # Remove the item from the scene
	
