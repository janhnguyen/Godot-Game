extends CanvasLayer

onready var pause_menu = $PauseMenu
var paused = false
var battling = false

func _input(event) :
	if event.is_action_pressed("inventory") :
		$inventory.visible = !$inventory.visible
		if ($Profile.visible) :
			$Profile.visible = !$Profile.visible
	if event.is_action_pressed("Profile") :
		$Profile.visible = !$Profile.visible
		if ($inventory.visible) :
			$inventory.visible = !$inventory.visible

func enterBattle() :
	if ($inventory.visible) :
		$inventory.visible = !$inventory.visible
	if ($Profile.visible) :
		$Profile.visible = !$Profile.visible
	$battleScene.visible = !$battleScene.visible

func leaveBattle() : 
	#print("Leaving Battle!")
	$battleScene.visible = !$battleScene.visible
	battling = false
	#if Globals.getFlee():
		#$hpBar.value = Globals.getPlayerHP()

func _ready():
	$hpBar.value = Globals.getPlayerHP()
	# Connect the ResumeButton's signal directly if it's already part of the scene tree
	var resume_button = pause_menu.get_node("MarginContainer/VBoxContainer/Resume")
	if resume_button:
		resume_button.connect("resume_pressed", self, "_on_ResumeGame")
	else:
		print("ResumeButton not found in PauseMenu")

func _on_ResumeGame():
	print("Resume game called")
	if paused: # Ensures game is paused before attempting to resume
		pauseMenu()

# warning-ignore:unused_argument
func _process(delta):
	
	if (Globals.getCombat()):
		if (!battling):
			#print("Entering Battle!")
			enterBattle()
			battling = true
	else :
		battling = false
	
	if (Globals.get_party2Portrait() != null) :
		$partyMember1.visible = true
		$partyMember1.texture = Globals.get_party2Portrait()
		$partyMember1/name.text = "Lv" + str(Globals.get_party2Level()) + " " + str(Globals.get_party2Name())
	
	if (Globals.get_party3Portrait() != null) :
		$partyMember2.visible = true
		$partyMember2.texture = Globals.get_party3Portrait()
		$partyMember2/name.text = "Lv" + str(Globals.get_party3Level()) + " " + str(Globals.get_party3Name())
	
	if (Globals.get_party4Portrait() != null) :
		$partyMember3.visible = true
		$partyMember3.texture = Globals.get_party4Portrait()
		$partyMember3/name.text = "Lv" + str(Globals.get_party4Level()) + " " + str(Globals.get_party4Name())
	
	if (Globals.get_party5Portrait() != null) :
		$partyMember4.visible = true
		$partyMember4.texture = Globals.get_party5Portrait()
		$partyMember4/name.text = "Lv" + str(Globals.get_party5Level()) + " " + str(Globals.get_party5Name())
	
	if (!battling and $battleScene.visible) :
		leaveBattle()

	if Input.is_action_just_pressed('pause'):
		pauseMenu()

func pauseMenu():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
		
	paused = !paused
