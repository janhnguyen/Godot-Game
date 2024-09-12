extends Node2D

signal waitingForPlayer
signal endBattle
signal userClicked

#player variables
var playerHP = null
var playerMaxHP = null
var playerAttack = null
var playerDefense = null
var playerSpeed = null
var playerLevel = null
var playerExp = null

#party2 variables
var party2Name = null
var party2HP = -1
var party2MaxHP = null
var party2Attack = null
var party2Defense = null
var party2Speed = 0
var party2Level = null
var party2Exp = null

#party3 variables
var party3Name = null
var party3HP = -1
var party3MaxHP = null
var party3Attack = null
var party3Defense = null
var party3Speed = 0
var party3Level = null
var party3Exp = null

#party4 variables
var party4Name = null
var party4HP = -1
var party4MaxHP = null
var party4Attack = null
var party4Defense = null
var party4Speed = 0
var party4Level = null
var party4Exp = null

#party5 variables
var party5Name = null
var party5HP = -1
var party5MaxHP = null
var party5Attack = null
var party5Defense = null
var party5Speed = 0
var party5Level = null
var party5Exp = null

#enemy variables
var enemyName = null
var enemyMaxHP = null
var enemyHP =  null
var enemyAttack = null
var enemyDefense = null
var enemySpeed = null
var enemyExp = null

var currentlyInBattle = false
var partyTurn = null
var partyAttack = null

func _ready():
	pass

func _process(_delta) :
	if (Globals.getCombat() and !currentlyInBattle) :
		beginBattle()
		currentlyInBattle = true

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT && event.pressed:
			emit_signal("userClicked")

func _on_attackButton_pressed():
	var damage = max(1, partyAttack - enemyDefense)
	enemyHP -= damage
	$enemyPortrait/enemyHPBar.value = enemyHP
	printToText(str(partyTurn) + " has dealt " + str(damage) + " damage to " + str(enemyName) + "!")
	emit_signal("waitingForPlayer")

func _on_itemButton_pressed():
	#View inventory in combat
	var inventory = get_parent().get_child(10)
	if (inventory.visible):
		inventory.z_index -= 1
	else:
		inventory.z_index +=1
	inventory.visible = !inventory.visible

func _on_fleeBattle_pressed():
	Globals.setPlayerHP(playerHP)
	Globals.set_party2HP(party2HP)
	Globals.set_party3HP(party3HP)
	Globals.set_party4HP(party4HP)
	Globals.set_party5HP(party5HP)
	Globals.setFlee(true)
	Globals.setCombat(false)

func _on_nextLevelButton_pressed():
	Globals.setNextLevel(true)
	Globals.increaseLevelCount()
	Globals.setCombat(false)
	currentlyInBattle = false
	$endScreen.visible = false
	$endScreen/nextLevelButton.visible = false
	$endScreen/captureButton.visible = false
	if Globals.getPartyCount()<=3:
		$endScreen/captureButton.visible = true
	emit_signal("endBattle")

#capture enemy func can go here, check if EnemyDead before offering capture, put capture button on endScreen scene
func _on_captureButton_pressed():
	if (Globals.getPartyCount()==4):
		print("Party Full:", Globals.getPartyCount(),", Swap?")
		$endScreen/captureButton.visible = false
		$endScreen/partyFull.visible = true
		$endScreen/nextLevelButton.visible = true
	else:
		#print("Capture Enemy?")
		Globals.increasePartyCount()
		Globals.setCapture(true)
		addToParty($enemyPortrait.texture, enemyName, enemyMaxHP, enemyAttack, enemyDefense, enemySpeed)
		_on_nextLevelButton_pressed()
		$endScreen.visible = false
		emit_signal("endBattle")
		$endScreen/nextLevelButton.visible = false
	$endScreen/captureButton.visible = false

func addToParty(portrait, name, HP, attack, defense, speed) :
	if (party2Name == null) :
		$partyMember2.visible = true
		$partyMember2/p2HPBar.visible = true
		Globals.set_party2Portrait(portrait)
		Globals.set_party2Name(name)
		Globals.set_party2HP(HP)
		Globals.set_party2MaxHP(HP)
		Globals.set_party2Attack(attack)
		Globals.set_party2Defense(defense)
		Globals.set_party2Speed(speed)
		Globals.set_party2Level(Globals.getLevelCount())
		Globals.set_party2Exp(0)
	elif (party3Name == null) :
		$partyMember3.visible = true
		$partyMember3/p3HPBar.visible = true
		Globals.set_party3Portrait(portrait)
		Globals.set_party3Name(name)
		Globals.set_party3HP(HP)
		Globals.set_party3MaxHP(HP)
		Globals.set_party3Attack(attack)
		Globals.set_party3Defense(defense)
		Globals.set_party3Speed(speed)
		Globals.set_party3Level(Globals.getLevelCount())
		Globals.set_party3Exp(0)
	elif (party4Name == null) :
		$partyMember4.visible = true
		$partyMember4/p4HPBar.visible = true
		Globals.set_party4Portrait(portrait)
		Globals.set_party4Name(name)
		Globals.set_party4HP(HP)
		Globals.set_party4MaxHP(HP)
		Globals.set_party4Attack(attack)
		Globals.set_party4Defense(defense)
		Globals.set_party4Speed(speed)
		Globals.set_party4Level(Globals.getLevelCount())
		Globals.set_party4Exp(0)
	else :
		$partyMember5.visible = true
		$partyMember5/p5HPBar.visible = true
		Globals.set_party5Portrait(portrait)
		Globals.set_party5Name(name)
		Globals.set_party5HP(HP)
		Globals.set_party5MaxHP(HP)
		Globals.set_party5Attack(attack)
		Globals.set_party5Defense(defense)
		Globals.set_party5Speed(speed)
		Globals.set_party5Level(Globals.getLevelCount())
		Globals.set_party5Exp(0)

func _on_returnToMenu_pressed():
	Globals.setLost(true)
	$endScreen/nextLevelButton.visible = false
	$endScreen/captureButton.visible = false
	$endScreen/returnToMenu.visible = true
	currentlyInBattle = false
	$endScreen.visible = false
	emit_signal("endBattle")

func enemyTurn() :
	var damage = enemyAttack #max(1, enemyAttack - playerDefense)
	if ($playerPortrait/playerHPBar.value > 0) :
		playerHP -= damage
		$playerPortrait/playerHPBar.value = playerHP
	#elif (playerHP <= 0) :
	#	printToText(str(Globals.getPlayerName) + " has fainted.")
	if ($partyMember2/p2HPBar.value > 0) :
		party2HP -= damage
		$partyMember2/p2HPBar.value = party2HP
	#elif (party2HP <= 0) :
	#	printToText(str(party2Name) + " has fainted.")
	if ($partyMember3/p3HPBar.value > 0) :
		party3HP -= damage
		$partyMember3/p3HPBar.value = party3HP
	#elif (party3HP <= 0) :
	#	printToText(str(party3Name) + " has fainted.")
	if ($partyMember4/p4HPBar.value > 0) :
		party4HP -= damage
		$partyMember4/p4HPBar.value = party4HP
	#elif (party4HP <= 0) :
	#	printToText(str(party4Name) + " has fainted.")
	if ($partyMember5/p5HPBar.value > 0) :
		party5HP -= damage
		$partyMember5/p5HPBar.value = party5HP
	#elif (party5HP <= 0) :
	#	printToText(str(party5Name) + " has fainted.")
	
	printToText(str(enemyName) + " has dealt " + str(damage) + " damage!")

func printToText(text) :
	if ($firstText.text == "") :
		$firstText.text = text
	elif ($secondText.text == "") :
		$secondText.text = $firstText.text
		$firstText.text = text
	else :
		$thirdText.text = $secondText.text
		$secondText.text = $firstText.text
		$firstText.text = text

#IGNORE THIS WILL LOOK BAD NO MATTER WHAT 
func printToTextEnd(text) :
	if ($endScreen/firstText.text == "") :
		$endScreen/firstText.text = text
	elif ($endScreen/secondText.text == "") :
		$endScreen/secondText.text = $endScreen/firstText.text
		$endScreen/firstText.text = text
	elif ($endScreen/thirdText.text == "") :
		$endScreen/thirdText.text = $endScreen/secondText.text
		$endScreen/secondText.text = $endScreen/firstText.text
		$endScreen/firstText.text = text
	elif ($endScreen/fourthText.text == "") :
		$endScreen/fourthText.text = $endScreen/thirdText.text
		$endScreen/thirdText.text = $endScreen/secondText.text
		$endScreen/secondText.text = $endScreen/firstText.text
		$endScreen/firstText.text = text
	elif ($endScreen/fifthText.text == "") :
		$endScreen/fifthText.text = $endScreen/fourthText.text
		$endScreen/fourthText.text = $endScreen/thirdText.text
		$endScreen/thirdText.text = $endScreen/secondText.text
		$endScreen/secondText.text = $endScreen/firstText.text
		$endScreen/firstText.text = text
	elif ($endScreen/sixthText.text == "") :
		$endScreen/sixthText.text = $endScreen/fifthText.text
		$endScreen/fifthText.text = $endScreen/fourthText.text
		$endScreen/fourthText.text = $endScreen/thirdText.text
		$endScreen/thirdText.text = $endScreen/secondText.text
		$endScreen/secondText.text = $endScreen/firstText.text
		$endScreen/firstText.text = text
	else :
		$endScreen/seventhText.text = $endScreen/sixthText.text
		$endScreen/sixthText.text = $endScreen/fifthText.text
		$endScreen/fifthText.text = $endScreen/fourthText.text
		$endScreen/fourthText.text = $endScreen/thirdText.text
		$endScreen/thirdText.text = $endScreen/secondText.text
		$endScreen/secondText.text = $endScreen/firstText.text
		$endScreen/firstText.text = text

#clears text from in-game text menu and end screen
func clearText() :
	$thirdText.text = ""
	$secondText.text = ""
	$firstText.text = ""
	$endScreen/seventhText.text = ""
	$endScreen/sixthText.text = ""
	$endScreen/fifthText.text = ""
	$endScreen/fourthText.text = ""
	$endScreen/thirdText.text = ""
	$endScreen/secondText.text = ""
	$endScreen/firstText.text = ""

func battleOver() :
	if (Globals.getFlee()) :
		return "Lose"
	if (enemyHP <= 0) :
		if Globals.getEnemyName()=="Mimic":
			$endScreen/captureButton.visible = false
		return "Win"
	if (playerHP <= 0 && party2HP <= 0 && party3HP <= 0 && party4HP <= 0 && party5HP <= 0) :
		return "Lose"
	return "no"

func beginBattle() :
	
	#call player variables
	playerHP = Globals.getPlayerHP()
	playerMaxHP = Globals.getPlayerMaxHP()
	playerAttack = Globals.getPlayerAttack()
	playerDefense = Globals.getPlayerDefense()
	playerSpeed = Globals.getPlayerSpeed()
	playerLevel = Globals.getPlayerLevel()
	playerExp = Globals.getPlayerExp()
	
	#call additional party member variables here
	if (1 <= Globals.getPartyCount()) :
		$partyMember2.texture = Globals.get_party2Portrait()
		party2Name = Globals.get_party2Name()
		party2Attack = Globals.get_party2Attack()
		party2Defense = Globals.get_party2Defense()
		party2Speed = Globals.get_party2Speed()
		party2HP = Globals.get_party2HP()
		party2MaxHP = Globals.get_party2MaxHP()
		party2Level = Globals.get_party2Level()
		party2Exp = Globals.get_party2Exp()
		$partyMember2/p2HPBar.max_value = party2HP
		$partyMember2/p2HPBar.value = party2HP
	if (2 <= Globals.getPartyCount()) :
		$partyMember3.texture = Globals.get_party3Portrait()
		party3Name = Globals.get_party3Name()
		party3Attack = Globals.get_party3Attack()
		party3Defense = Globals.get_party3Defense()
		party3Speed = Globals.get_party3Speed()
		party3HP = Globals.get_party3HP()
		party3MaxHP = Globals.get_party3MaxHP()
		party3Level = Globals.get_party3Level()
		party3Exp = Globals.get_party3Exp()
		$partyMember3/p3HPBar.max_value = party3HP
		$partyMember3/p3HPBar.value = party3HP
	if (3 <= Globals.getPartyCount()) :
		$partyMember4.texture = Globals.get_party4Portrait()
		party4Name = Globals.get_party4Name()
		party4Attack = Globals.get_party4Attack()
		party4Defense = Globals.get_party4Defense()
		party4Speed = Globals.get_party4Speed()
		party4HP = Globals.get_party4HP()
		party4MaxHP = Globals.get_party4MaxHP()
		party4Level = Globals.get_party4Level()
		party4Exp = Globals.get_party4Exp()
		$partyMember4/p4HPBar.max_value = party4HP
		$partyMember4/p4HPBar.value = party4HP
	if (4 <= Globals.getPartyCount()) :
		$partyMember5.texture = Globals.get_party5Portrait()
		party5Name = Globals.get_party5Name()
		party5Attack = Globals.get_party5Attack()
		party5Defense = Globals.get_party5Defense()
		party5Speed = Globals.get_party5Speed()
		party5HP = Globals.get_party5HP()
		party5MaxHP = Globals.get_party5MaxHP()
		party5Level = Globals.get_party5Level()
		party5Exp = Globals.get_party5Exp()
		$partyMember5/p5HPBar.max_value = party5HP
		$partyMember5/p5HPBar.value = party5HP
	
	#call enemy variables
	$enemyPortrait.texture = Globals.getEnemyPortrait()
	enemyName = Globals.getEnemyName()
	enemyHP = Globals.getEnemyHP()*Globals.getLevelCount()
	enemyAttack = Globals.getEnemyAttack()*Globals.getLevelCount()
	enemyDefense = Globals.getEnemyDefense()#*Globals.getLevelCount()
	enemySpeed = Globals.getEnemySpeed()
	enemyExp = Globals.getEnemyExp()*Globals.getLevelCount()
	enemyMaxHP = enemyHP
	
	#setting up HP bars
	$playerPortrait/playerHPBar.max_value = playerMaxHP
	$playerPortrait/playerHPBar.value = playerHP
	$enemyPortrait/enemyHPBar.max_value = enemyHP
	$enemyPortrait/enemyHPBar.value = enemyHP
	
	#speeds for combat turns
	var playerBattleSpeed = playerSpeed
	var party2BattleSpeed = party2Speed
	var party3BattleSpeed = party3Speed
	var party4BattleSpeed = party4Speed
	var party5BattleSpeed = party5Speed
	var enemyBattleSpeed = enemySpeed
	
	printToText("Entering battle against " + str(enemyName) + "!")
	
	#begin battle loop
	while ("no" in battleOver()) :
		#turn determined by which speed hits 100 first, in order of player > party member (by number) > enemy
		if (playerBattleSpeed == 100 && $playerPortrait/playerHPBar.value > 0) :
			
			partyTurn = Globals.getPlayerName()
			print(str(partyTurn) + "'s turn.")
			partyAttack = playerAttack
			yield(self, "waitingForPlayer")
			playerBattleSpeed = playerSpeed
			
		elif (party2BattleSpeed == 100 && $partyMember2/p2HPBar.value > 0) :
			
			partyTurn = party2Name
			print(str(partyTurn) + "'s turn.")
			partyAttack = party2Attack
			yield(self, "waitingForPlayer")
			party2BattleSpeed = party2Speed
			
		elif (party3BattleSpeed == 100 && $partyMember3/p3HPBar.value > 0) :
			
			partyTurn = party3Name
			print(str(partyTurn) + "'s turn.")
			partyAttack = party3Attack
			yield(self, "waitingForPlayer")
			party3BattleSpeed = party3Speed
			
		elif (party4BattleSpeed == 100 && $partyMember4/p4HPBar.value > 0) :
			
			partyTurn = party4Name
			print(str(partyTurn) + "'s turn.")
			partyAttack = party4Attack
			yield(self, "waitingForPlayer")
			party4BattleSpeed = party4Speed
			
		elif (party5BattleSpeed == 100 && $partyMember5/p5HPBar.value > 0) :
			
			partyTurn = party5Name
			print(str(partyTurn) + "'s turn.")
			partyAttack = party5Attack
			yield(self, "waitingForPlayer")
			party5BattleSpeed = party5Speed
			
		elif (enemyBattleSpeed == 100) :
			
			print("Enemy's turn.")
			enemyTurn()
			enemyBattleSpeed = enemySpeed
			
		else :
			
			playerBattleSpeed += 1
			party2BattleSpeed += 1
			party3BattleSpeed += 1
			party4BattleSpeed += 1
			party5BattleSpeed += 1
			enemyBattleSpeed += 1
	
	#end of battle calculations
	$endScreen.visible = true
	$endScreen/resultHeader.text = "Result of battle : " + str(battleOver())
	
	if ("Win" in battleOver()) :
		
		#Check here for party Death, if party_HP<=0 remove from party
		if Globals.getPartyCount()>0:
			checkParty()
		
		playerExp += int(enemyExp)
		Globals.setPlayerExp(playerExp)
		printToTextEnd(str(Globals.getPlayerName()) + " has gained " + str(enemyExp) + " Experience!")
		yield(self, "userClicked")
		
		while (playerExp > playerLevel * 10) :
			playerExp -= playerLevel * 10
			playerLevel += 1
			Globals.levelUp()
			Globals.setPlayerLevel(playerLevel)
			Globals.setPlayerExp(playerExp)
			printToTextEnd(str(Globals.getPlayerName()) + " is now Level " + str(playerLevel) + "!")
			yield(self, "userClicked")
		
		if (1 <= Globals.getPartyCount()) :
			
			party2Exp += int(enemyExp)
			Globals.set_party2Exp(party2Exp)
			printToTextEnd(str(party2Name) + " has gained " + str(enemyExp) + " Experience!")
			yield(self, "userClicked")
			
			while (party2Exp > party2Level * 10) :
				party2Exp -= party2Level * 10
				party2Level += 1
				Globals.levelUp2()
				Globals.set_party2Level(party2Level)
				Globals.set_party2Exp(party2Exp)
				printToTextEnd(str(party2Name) + " is now Level " + str(party2Level) + "!")
				yield(self, "userClicked")
		
		if (2 <= Globals.getPartyCount()) :
			
			party3Exp += int(enemyExp)
			Globals.set_party3Exp(party3Exp)
			printToTextEnd(str(party3Name) + " has gained " + str(enemyExp) + " Experience!")
			yield(self, "userClicked")
			
			while (party3Exp > party3Level * 10) :
				party3Exp -= party3Level * 10
				party3Level += 1
				Globals.levelUp3()
				Globals.set_party3Level(party3Level)
				Globals.set_party3Exp(party3Exp)
				printToTextEnd(str(party3Name) + " is now Level " + str(party3Level) + "!")
				yield(self, "userClicked")
		
		if (3 <= Globals.getPartyCount()) :
			
			party4Exp += int(enemyExp)
			Globals.set_party4Exp(party4Exp)
			printToTextEnd(str(party4Name) + " has gained " + str(enemyExp) + " Experience!")
			yield(self, "userClicked")
			
			while (party4Exp > party4Level * 10) :
				party4Exp -= party4Level * 10
				party4Level += 1
				Globals.levelUp4()
				Globals.set_party4Level(party4Level)
				Globals.set_party4Exp(party4Exp)
				printToTextEnd(str(party4Name) + " is now Level " + str(party4Level) + "!")
				yield(self, "userClicked")
		
		if (4 <= Globals.getPartyCount()) :
			
			party5Exp += int(enemyExp)
			Globals.set_party5Exp(party5Exp)
			printToTextEnd(str(party5Name) + " has gained " + str(enemyExp) + " Experience!")
			yield(self, "userClicked")
			
			while (party5Exp > party5Level * 10) :
				party5Exp -= party5Level * 10
				party5Level += 1
				Globals.levelUp5()
				Globals.set_party5Level(party5Level)
				Globals.set_party5Exp(party5Exp)
				printToTextEnd(str(party5Name) + " is now Level " + str(party5Level) + "!")
				yield(self, "userClicked")
	 
		$endScreen/nextLevelButton.visible = true
		if !("Mimic" in enemyName || Globals.getPartyCount() >= 4) :
			$endScreen/captureButton.visible = true
		
	else :
		print("LOST BATTLE")
		$endScreen/captureButton.visible = false
		$endScreen/returnToMenu.visible = false
		printToTextEnd(str(Globals.getPlayerName()) + " has fainted!")
		yield(self, "userClicked")
		printToTextEnd("Return to Menu.")
		yield(self, "userClicked")
		#Globals.setFlee(true)
	
	yield(self, "endBattle")
	Globals.setCombat(false)
	currentlyInBattle = false
	$endScreen/nextLevelButton.visible = false
	$endScreen/captureButton.visible = false
	clearText()

func checkParty():
	var removeIndex := []
	#print("Party 2 MaxHP:", party2MaxHP)
	if party2MaxHP!=null:
		print("Party 2 HP: ", party2HP)
		if party2HP<=0:
			printToTextEnd(str(party2Name) + " has left the party.")
			#party2Name=null
			removeIndex.append(0)
	#print("Party 3 MaxHP:", party3MaxHP)
	if party3MaxHP!=null:
		print("Party 3 HP: ", party3HP)
		if party3HP<=0:
			printToTextEnd(str(party3Name) + " has left the party.")
			#party3Name=null
			removeIndex.append(1)
	#print("Party 4 MaxHP:", party4MaxHP)
	if party4MaxHP!=null:
		print("Party 4 HP: ", party4HP)
		if party4HP<=0:
			printToTextEnd(str(party4Name) + " has left the party.")
			#party4Name=null
			removeIndex.append(2)
	#print("Party 5 MaxHP:", party5MaxHP)
	if party5MaxHP!=null:
		print("Party 5 HP: ", party5HP)
		if party5HP<=0:
			printToTextEnd(str(party5Name) + " has left the party.")
			#party5Name=null
			removeIndex.append(3)
	#If there are members to remove, remove them
	if len(removeIndex)>0:
		removeParty(removeIndex)

func removeParty(removeIndex):
	var levelNode = get_parent().get_parent()
	var hudParty1 = get_parent().get_child(6)
	var hudParty2 = get_parent().get_child(7)
	var hudParty3 = get_parent().get_child(8)
	var hudParty4 = get_parent().get_child(9)
	var partyList = Globals.getPartyList()
	var partyTemp := []
	for i in len(partyList):
		#If still alive, add to new party list
		if not (i in removeIndex):
			partyTemp.append(partyList[i])
		else:
			print("Remove Node at Index: ", i)
			print(hudParty1, hudParty2, hudParty3, hudParty4)
			levelNode.get_child(len(levelNode.get_children())-len(partyList)+i).queue_free()
	Globals.setPartyCount(len(partyTemp))
	#print(partyTemp)
	Globals.setPartyList(partyTemp)
	#Null all party member fields completely
	levelNode.resetParty()
	if len(partyTemp)==0:
		#Just reset all and exit
		#Update local variables
		party2Name = null
		party2HP = -1
		party2MaxHP = null
		party2Attack = null
		party2Defense = null
		party2Speed = 0
		party2Level = null
		party2Exp = null
		
		party3Name = null
		party3HP = -1
		party3MaxHP = null
		party3Attack = null
		party3Defense = null
		party3Speed = 0
		party3Level = null
		party3Exp = null
		
		party4Name = null
		party4HP = -1
		party4MaxHP = null
		party4Attack = null
		party4Defense = null
		party4Speed = 0
		party4Level = null
		party4Exp = null
		
		party5Name = null
		party5HP = -1
		party5MaxHP = null
		party5Attack = null
		party5Defense = null
		party5Speed = 0
		party5Level = null
		party5Exp = null
		
		hudParty1.visible = false
		hudParty2.visible = false
		hudParty3.visible = false
		hudParty4.visible = false
		
		$partyMember2.visible = false
		$partyMember2/p2HPBar.visible = false
		$partyMember3.visible = false
		$partyMember3/p3HPBar.visible = false
		$partyMember4.visible = false
		$partyMember4/p4HPBar.visible = false
		$partyMember5.visible = false
		$partyMember5/p5HPBar.visible = false
	elif len(partyTemp)==1:
		#Only one party member left
		Globals.set_party2Portrait(partyTemp[0].partyPortrait)
		Globals.set_party2Name(partyTemp[0].partyName)
		Globals.set_party2HP(partyTemp[0].partyHP)
		Globals.set_party2MaxHP(partyTemp[0].partyMaxHP)
		Globals.set_party2Attack(partyTemp[0].partyAttack)
		Globals.set_party2Defense(partyTemp[0].partyDefense)
		Globals.set_party2Speed(partyTemp[0].partySpeed)
		Globals.set_party2Level(partyTemp[0].partyLevel)
		Globals.set_party2Exp(partyTemp[0].partyExp)
		
		party2Name = partyTemp[0].partyName
		party3Name = null
		party4Name = null
		party5Name = null
		
		$partyMember2.visible = true
		$partyMember2/p2HPBar.value = Globals.get_party2MaxHP()
		$partyMember2/p2HPBar.max_value = Globals.get_party2MaxHP()
		$partyMember2/p2HPBar.visible = true
		$partyMember3.visible = false
		$partyMember3/p3HPBar.visible = false
		$partyMember4.visible = false
		$partyMember4/p4HPBar.visible = false
		$partyMember5.visible = false
		$partyMember5/p5HPBar.visible = false
	elif len(partyTemp)==2:
		#Two party members left
		Globals.set_party2Portrait(partyTemp[0].partyPortrait)
		Globals.set_party2Name(partyTemp[0].partyName)
		Globals.set_party2HP(partyTemp[0].partyHP)
		Globals.set_party2MaxHP(partyTemp[0].partyMaxHP)
		Globals.set_party2Attack(partyTemp[0].partyAttack)
		Globals.set_party2Defense(partyTemp[0].partyDefense)
		Globals.set_party2Speed(partyTemp[0].partySpeed)
		Globals.set_party2Level(partyTemp[0].partyLevel)
		Globals.set_party2Exp(partyTemp[0].partyExp)
		
		Globals.set_party3Portrait(partyTemp[1].partyPortrait)
		Globals.set_party3Name(partyTemp[1].partyName)
		Globals.set_party3HP(partyTemp[1].partyHP)
		Globals.set_party3MaxHP(partyTemp[1].partyMaxHP)
		Globals.set_party3Attack(partyTemp[1].partyAttack)
		Globals.set_party3Defense(partyTemp[1].partyDefense)
		Globals.set_party3Speed(partyTemp[1].partySpeed)
		Globals.set_party3Level(partyTemp[1].partyLevel)
		Globals.set_party3Exp(partyTemp[1].partyExp)
		
		party2Name = partyTemp[0].partyName
		party3Name = partyTemp[1].partyName
		party4Name = null
		party5Name = null
		
		$partyMember2.visible = true
		$partyMember2/p2HPBar.value = Globals.get_party2MaxHP()
		$partyMember2/p2HPBar.max_value = Globals.get_party2MaxHP()
		$partyMember2/p2HPBar.visible = true
		$partyMember3.visible = true
		$partyMember3/p3HPBar.value = Globals.get_party3MaxHP()
		$partyMember3/p3HPBar.max_value = Globals.get_party3MaxHP()
		$partyMember3/p3HPBar.visible = true
		$partyMember4.visible = false
		$partyMember4/p4HPBar.visible = false
		$partyMember5.visible = false
		$partyMember5/p5HPBar.visible = false
	elif len(partyTemp)==3:
		#Three party members left
		Globals.set_party2Portrait(partyTemp[0].partyPortrait)
		Globals.set_party2Name(partyTemp[0].partyName)
		Globals.set_party2HP(partyTemp[0].partyHP)
		Globals.set_party2MaxHP(partyTemp[0].partyMaxHP)
		Globals.set_party2Attack(partyTemp[0].partyAttack)
		Globals.set_party2Defense(partyTemp[0].partyDefense)
		Globals.set_party2Speed(partyTemp[0].partySpeed)
		Globals.set_party2Level(partyTemp[0].partyLevel)
		Globals.set_party2Exp(partyTemp[0].partyExp)
		
		Globals.set_party3Portrait(partyTemp[1].partyPortrait)
		Globals.set_party3Name(partyTemp[1].partyName)
		Globals.set_party3HP(partyTemp[1].partyHP)
		Globals.set_party3MaxHP(partyTemp[1].partyMaxHP)
		Globals.set_party3Attack(partyTemp[1].partyAttack)
		Globals.set_party3Defense(partyTemp[1].partyDefense)
		Globals.set_party3Speed(partyTemp[1].partySpeed)
		Globals.set_party3Level(partyTemp[1].partyLevel)
		Globals.set_party3Exp(partyTemp[1].partyExp)
		
		Globals.set_party4Portrait(partyTemp[2].partyPortrait)
		Globals.set_party4Name(partyTemp[2].partyName)
		Globals.set_party4HP(partyTemp[2].partyHP)
		Globals.set_party4MaxHP(partyTemp[2].partyMaxHP)
		Globals.set_party4Attack(partyTemp[2].partyAttack)
		Globals.set_party4Defense(partyTemp[2].partyDefense)
		Globals.set_party4Speed(partyTemp[2].partySpeed)
		Globals.set_party4Level(partyTemp[2].partyLevel)
		Globals.set_party4Exp(partyTemp[2].partyExp)
		
		party2Name = partyTemp[0].partyName
		party3Name = partyTemp[1].partyName
		party4Name = partyTemp[2].partyName
		party5Name = null
		
		$partyMember2.visible = true
		$partyMember2/p2HPBar.value = Globals.get_party2MaxHP()
		$partyMember2/p2HPBar.max_value = Globals.get_party2MaxHP()
		$partyMember2/p2HPBar.visible = true
		$partyMember3.visible = true
		$partyMember3/p3HPBar.value = Globals.get_party3MaxHP()
		$partyMember3/p3HPBar.max_value = Globals.get_party3MaxHP()
		$partyMember3/p3HPBar.visible = true
		$partyMember4.visible = true
		$partyMember4/p3HPBar.value = Globals.get_party4MaxHP()
		$partyMember4/p3HPBar.max_value = Globals.get_party4MaxHP()
		$partyMember4/p4HPBar.visible = true
		$partyMember5.visible = false
		$partyMember5/p5HPBar.visible = false
	elif len(partyTemp)==4:
		#All party members left
		Globals.set_party2Portrait(partyTemp[0].partyPortrait)
		Globals.set_party2Name(partyTemp[0].partyName)
		Globals.set_party2HP(partyTemp[0].partyHP)
		Globals.set_party2MaxHP(partyTemp[0].partyMaxHP)
		Globals.set_party2Attack(partyTemp[0].partyAttack)
		Globals.set_party2Defense(partyTemp[0].partyDefense)
		Globals.set_party2Speed(partyTemp[0].partySpeed)
		Globals.set_party2Level(partyTemp[0].partyLevel)
		Globals.set_party2Exp(partyTemp[0].partyExp)
		
		Globals.set_party3Portrait(partyTemp[1].partyPortrait)
		Globals.set_party3Name(partyTemp[1].partyName)
		Globals.set_party3HP(partyTemp[1].partyHP)
		Globals.set_party3MaxHP(partyTemp[1].partyMaxHP)
		Globals.set_party3Attack(partyTemp[1].partyAttack)
		Globals.set_party3Defense(partyTemp[1].partyDefense)
		Globals.set_party3Speed(partyTemp[1].partySpeed)
		Globals.set_party3Level(partyTemp[1].partyLevel)
		Globals.set_party3Exp(partyTemp[1].partyExp)
		
		Globals.set_party4Portrait(partyTemp[2].partyPortrait)
		Globals.set_party4Name(partyTemp[2].partyName)
		Globals.set_party4HP(partyTemp[2].partyHP)
		Globals.set_party4MaxHP(partyTemp[2].partyMaxHP)
		Globals.set_party4Attack(partyTemp[2].partyAttack)
		Globals.set_party4Defense(partyTemp[2].partyDefense)
		Globals.set_party4Speed(partyTemp[2].partySpeed)
		Globals.set_party4Level(partyTemp[2].partyLevel)
		Globals.set_party4Exp(partyTemp[2].partyExp)
		
		Globals.set_party5Portrait(partyTemp[3].partyPortrait)
		Globals.set_party5Name(partyTemp[3].partyName)
		Globals.set_party5HP(partyTemp[3].partyHP)
		Globals.set_party5MaxHP(partyTemp[3].partyMaxHP)
		Globals.set_party5Attack(partyTemp[3].partyAttack)
		Globals.set_party5Defense(partyTemp[3].partyDefense)
		Globals.set_party5Speed(partyTemp[3].partySpeed)
		Globals.set_party5Level(partyTemp[3].partyLevel)
		Globals.set_party5Exp(partyTemp[3].partyExp)
		
		party2Name = partyTemp[0].partyName
		party3Name = partyTemp[1].partyName
		party4Name = partyTemp[2].partyName
		party5Name = partyTemp[3].partyName
		
		$partyMember2.visible = true
		$partyMember2/p2HPBar.value = Globals.get_party2MaxHP()
		$partyMember2/p2HPBar.max_value = Globals.get_party2MaxHP()
		$partyMember2/p2HPBar.visible = true
		$partyMember3.visible = true
		$partyMember3/p3HPBar.value = Globals.get_party3MaxHP()
		$partyMember3/p3HPBar.max_value = Globals.get_party3MaxHP()
		$partyMember3/p3HPBar.visible = true
		$partyMember4.visible = true
		$partyMember4/p3HPBar.value = Globals.get_party4MaxHP()
		$partyMember4/p3HPBar.max_value = Globals.get_party4MaxHP()
		$partyMember4/p4HPBar.visible = true
		$partyMember5.visible = true
		$partyMember5/p3HPBar.value = Globals.get_party5MaxHP()
		$partyMember5/p3HPBar.max_value = Globals.get_party5MaxHP()
		$partyMember5/p5HPBar.visible = true
