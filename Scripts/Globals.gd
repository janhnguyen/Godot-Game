extends Node

var global_volume = 0

#player variables for ui/battle purposes
var playerName = "Adventurer"
var playerHP = 100
var playerMaxHP = 100
var playerAttack = 10
var playerDefense = 5
var playerSpeed = 37
var playerLevel = 1
var playerExp = 0

var item=0

func setItem(value):
	item = value

func getItem():
	return item
	
#party2 variables
var party2Portrait : Texture = null
var party2Name = null
var party2HP = null
var party2MaxHP = null
var party2Attack = null
var party2Defense = null
var party2Speed = null
var party2Level = null
var party2Exp = null

#party3 variables
var party3Portrait : Texture = null
var party3Name = null
var party3HP = null
var party3MaxHP = null
var party3Attack = null
var party3Defense = null
var party3Speed = null
var party3Level = null
var party3Exp = null

#party4 variables
var party4Portrait : Texture = null
var party4Name = null
var party4HP = null
var party4MaxHP = null
var party4Attack = null
var party4Defense = null
var party4Speed = null
var party4Level = null
var party4Exp = null

#party5 variables
var party5Portrait : Texture = null
var party5Name = null
var party5HP = null
var party5MaxHP = null
var party5Attack = null
var party5Defense = null
var party5Speed = null
var party5Level = null
var party5Exp = null

#enemy variables for ui/battle purposes
var enemyPortrait : Texture = null
var enemyName = null
var enemyHP =  null
var enemyAttack = null
var enemyDefense = null
var enemySpeed = null
var enemyExp = null

#variables for setting combat state
var fleeing = false
var inCombat = false
var enemyDead = false
var capture = false

#variable for party size
var partyCount = 0
var partyFull = null
var partyList := []

#variable for level change and to track difficulty
var nextLevel = false
var lost = false
var levelCount = 1

func levelUp() :
	playerAttack += randi() % 5
	playerDefense += randi() % 5
	playerSpeed += 1
	playerMaxHP += randi() %10
	playerHP = playerMaxHP

func levelUp2() :
	party2Attack += randi() % 5
	party2Defense += randi() % 5
	party2Speed += 1
	party2MaxHP += randi() %10
	party2HP = party2MaxHP

func levelUp3() :
	party3Attack += randi() % 5
	party3Defense += randi() % 5
	party3Speed += 1
	party3MaxHP += randi() %10
	party3HP = party3MaxHP

func levelUp4() :
	party4Attack += randi() % 5
	party4Defense += randi() % 5
	party4Speed += 1
	party4MaxHP += randi() %10
	party4HP = party4MaxHP

func levelUp5() :
	party5Attack += randi() % 5
	party5Defense += randi() % 5
	party5Speed += 1
	party5MaxHP += randi() %10
	party5HP = party5MaxHP

#get/set functions for every variable
func set_global_volume(value):
	global_volume = value

func get_global_volume():
	return global_volume

func setPlayerName(value):
	playerName = value

func getPlayerName():
	return playerName

func setPlayerHP(value):
	playerHP = value

func getPlayerHP():
	return playerHP

func setPlayerMaxHP(value):
	playerMaxHP = value

func getPlayerMaxHP():
	return playerMaxHP	

func setPlayerAttack(value):
	playerAttack = value

func getPlayerAttack():
	return playerAttack

func setPlayerDefense(value):
	playerDefense = value

func getPlayerDefense():
	return playerDefense

func setPlayerSpeed(value):
	playerSpeed = value

func getPlayerSpeed():
	return playerSpeed

func setPlayerLevel(value):
	playerLevel = value

func getPlayerLevel():
	return playerLevel

func setPlayerExp(value):
	playerExp = value

func getPlayerExp():
	return playerExp

func setEnemyPortrait(value):
	enemyPortrait = value

func getEnemyPortrait():
	return enemyPortrait

func setEnemyName(value):
	enemyName = value

func getEnemyName():
	return enemyName

func setEnemyHP(value):
	enemyHP = value

func getEnemyHP():
	return enemyHP

func setEnemyAttack(value):
	enemyAttack = value

func getEnemyAttack():
	return enemyAttack

func setEnemyDefense(value):
	enemyDefense = value

func getEnemyDefense():
	return enemyDefense

func setEnemySpeed(value):
	enemySpeed = value

func getEnemySpeed():
	return enemySpeed

func setEnemyExp(value):
	enemyExp = value

func getEnemyExp():
	return enemyExp

func setCombat(value):
	inCombat = value

func getCombat():
	return inCombat

func setEnemyDead(value):
	enemyDead = value

func getEnemyDead():
	return enemyDead

func setFlee(value):
	fleeing = value

func getFlee():
	return fleeing
	
func setNextLevel(value):
	nextLevel = value
	
func getNextLevel():
	return nextLevel
	
func increaseLevelCount():
	levelCount += 1
	
func getLevelCount():
	return levelCount
	
func increasePartyCount():
	partyCount += 1

func setPartyCount(value):
	partyCount=value

func getPartyCount():
	return partyCount
	
func setCapture(value):
	capture = value

func getCapture():
	return capture

func setPartyFull(value):
	partyFull = value 

func getPartyFull():
	return partyFull

func setPartyList(value):
	partyList = value

func appendPartyList(value):
	partyList.append(value)

func getPartyList():
	return partyList

func setLost(value):
	lost = value

func getLost():
	return lost

# Getter and setter for party2Portrait
func get_party2Portrait():
	return party2Portrait

func set_party2Portrait(value):
	party2Portrait = value

# Getter and setter for party2Name
func get_party2Name():
	return party2Name

func set_party2Name(value):
	party2Name = value

# Getter and setter for party2HP
func get_party2HP():
	return party2HP

func set_party2HP(value):
	party2HP = value

func get_party2MaxHP():
	return party2MaxHP

func set_party2MaxHP(value):
	party2MaxHP = value

# Getter and setter for party2Attack
func get_party2Attack():
	return party2Attack

func set_party2Attack(value):
	party2Attack = value

# Getter and setter for party2Defense
func get_party2Defense():
	return party2Defense

func set_party2Defense(value):
	party2Defense = value

# Getter and setter for party2Speed
func get_party2Speed():
	return party2Speed

func set_party2Speed(value):
	party2Speed = value

# Getter and setter for party2Level
func get_party2Level():
	return party2Level

func set_party2Level(value):
	party2Level = value

# Getter and setter for party2Exp
func get_party2Exp():
	return party2Exp

func set_party2Exp(value):
	party2Exp = value

# Party 3 getters and setters
func get_party3Portrait():
	return party3Portrait

func set_party3Portrait(value):
	party3Portrait = value

func get_party3Name():
	return party3Name

func set_party3Name(value):
	party3Name = value

func get_party3HP():
	return party3HP

func set_party3HP(value):
	party3HP = value

func get_party3MaxHP():
	return party3MaxHP

func set_party3MaxHP(value):
	party3MaxHP = value

func get_party3Attack():
	return party3Attack

func set_party3Attack(value):
	party3Attack = value

func get_party3Defense():
	return party3Defense

func set_party3Defense(value):
	party3Defense = value

func get_party3Speed():
	return party3Speed

func set_party3Speed(value):
	party3Speed = value

func get_party3Level():
	return party3Level

func set_party3Level(value):
	party3Level = value

func get_party3Exp():
	return party3Exp

func set_party3Exp(value):
	party3Exp = value

# Party 4 getters and setters
func get_party4Portrait():
	return party4Portrait

func set_party4Portrait(value):
	party4Portrait = value

func get_party4Name():
	return party4Name

func set_party4Name(value):
	party4Name = value

func get_party4HP():
	return party4HP

func set_party4HP(value):
	party4HP = value

func get_party4MaxHP():
	return party4MaxHP

func set_party4MaxHP(value):
	party4MaxHP = value

func get_party4Attack():
	return party4Attack

func set_party4Attack(value):
	party4Attack = value

func get_party4Defense():
	return party4Defense

func set_party4Defense(value):
	party4Defense = value

func get_party4Speed():
	return party4Speed

func set_party4Speed(value):
	party4Speed = value

func get_party4Level():
	return party4Level

func set_party4Level(value):
	party4Level = value

func get_party4Exp():
	return party4Exp

func set_party4Exp(value):
	party4Exp = value

# Party 5 getters and setters
func get_party5Portrait():
	return party5Portrait

func set_party5Portrait(value):
	party5Portrait = value

func get_party5Name():
	return party5Name

func set_party5Name(value):
	party5Name = value

func get_party5HP():
	return party5HP

func set_party5HP(value):
	party5HP = value

func get_party5MaxHP():
	return party5MaxHP

func set_party5MaxHP(value):
	party5MaxHP = value

func get_party5Attack():
	return party5Attack

func set_party5Attack(value):
	party5Attack = value

func get_party5Defense():
	return party5Defense

func set_party5Defense(value):
	party5Defense = value

func get_party5Speed():
	return party5Speed

func set_party5Speed(value):
	party5Speed = value

func get_party5Level():
	return party5Level

func set_party5Level(value):
	party5Level = value

func get_party5Exp():
	return party5Exp

func set_party5Exp(value):
	party5Exp = value
