extends Area2D

var timer
	
func _ready():
	# Initialize the timer here to avoid repeated creation
	#timer = Timer.new()=
	timer = Timer.new()
	timer.one_shot = true
	add_child(timer)
	timer.connect("timeout", self, "_on_Timer_timeout")

func _on_Chest_body_entered(body):
	var item= Globals.getItem()
	if ("player" in str(body)) and item == 5 : # Ensure it's the player that touches the item
		if(Globals.getItem()!= 0):
			randomize()
			var whatItem = randi() % 4 + 1
			if whatItem == 1:
				got_Potion()
			elif whatItem == 2:
				got_Potion()
			elif whatItem == 3:
				got_Shield()
			elif whatItem == 4:
				got_Speed()
		timer.wait_time = 3.0 
		timer.start()
		position = Vector2(-1000, -1000)  # Make the node invisibl
		Globals.setItem(0)
		
		
func got_Potion():
	var health = Globals.getPlayerHP()
	health = health + 25
	Globals.setPlayerHP(health)
	$CanvasLayer/Label.text = "Gained 25 health!"
	$CanvasLayer/Label.visible = true

func got_Sword():
	var Attack = Globals.getPlayerAttack()
	Attack = Attack + 5
	Globals.setPlayerAttack(Attack)
	$CanvasLayer/Label.text = "Gained 5 Attack!"
	$CanvasLayer/Label.visible = true

func got_Shield():
	var defense = Globals.getPlayerDefense()
	defense= defense + 5
	Globals.setPlayerDefense(defense) 
	$CanvasLayer/Label.text = "Gained 5 Armor!"
	$CanvasLayer/Label.visible = true

func got_Speed():
	var speed = Globals.getPlayerSpeed()
	speed = speed + 5
	Globals.setPlayerSpeed(speed)
	$CanvasLayer/Label.text = "Gained 5 Speed!"
	$CanvasLayer/Label.visible = true

func _on_Timer_timeout():
	$CanvasLayer/Label.visible = false
