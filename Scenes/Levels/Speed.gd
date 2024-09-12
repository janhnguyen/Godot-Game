extends Area2D

# Declare member variables here. Examples:

#combat variables

var timer

func _ready():
	# Initialize the timer here to avoid repeated creation
	#timer = Timer.new()=
	timer = Timer.new()
	timer.one_shot = true
	add_child(timer)
	timer.connect("timeout", self, "_on_Timer_timeout")
	
	
func _on_SpeedItem_body_entered(body):
	var item= Globals.getItem()
# warning-ignore:unused_variable
	var Attack = Globals.getPlayerAttack()
	var speed = Globals.getPlayerSpeed()
	#print(item)
	if ("player" in str(body)) and item == 4 : # Ensure it's the player that touches the item
		speed = speed + 5
		Globals.setPlayerSpeed(speed)
		#emit_signal("player_collided")
		if(Globals.getItem()!= 0):
		 # Remove the item from the scene
			#var camera = get_viewport().get_camera()
			#var camera_position = camera.global_position
			#$Label.visible = true
			#$CanvasLayer/Label.rect_position = camera_position
			$CanvasLayer/Label.text = "Gained 5 Speed!"
			$CanvasLayer/Label.visible = true
			
			timer.wait_time = 3.0 
			timer.start()
			
		
		Globals.setItem(0)
		position = Vector2(-1000, -1000)
		
func _on_Timer_timeout():
	$CanvasLayer/Label.visible = false
		
		#Globals.showMessage(0) 
		#$CollisionShape2D.disabled = true
		#queue_free()
		
