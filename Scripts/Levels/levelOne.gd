extends Node2D

const FACTOR := 1.0 / 8.0 #Only used in poly-shaped rooms
#These are one option for textures
const TILE_WALKABLE := [3, 4, 5]
const TILE_OBSTACLE := [0, 1, 2]
#Another option
#const TILE_WALKABLE := [6, 7, 8]
#const TILE_OBSTACLE := [9, 10, 11]
#Dictionary for level globals? If I want to increase the globals on each repition I need a counter?

export var level_size := Vector2(100, 100)
export var rooms_size := Vector2(12, 12)
export var rooms_max := 9

onready var level: TileMap = $Level
onready var camera: Camera2D = $Camera2D 
onready var pause_menu = $PauseMenu

#player variables
onready var character: KinematicBody2D = $playerModel

#enemy variables
onready var enemies := [$enemy, $Danny, $Sid, $mimic]
var pickEnemy := RandomNumberGenerator.new()
onready var enemyIndex := pickEnemy.randi_range(0,3)
onready var enemyPortraits := [$enemy/portrait, $Danny/portrait, $Sid/portrait, $mimic/portrait]
onready var enemy: KinematicBody2D = enemies[enemyIndex]
onready var enemyPortrait = enemyPortraits[enemyIndex]

onready var shield: Area2D= $ShieldItem
#onready var shieldPortrait= $shield/portrait

onready var potion: Area2D = $HealthItem
onready var sword: Area2D = $AttackItem
onready var speed: Area2D = $SpeedItem
onready var chest: Area2D = $Chest

var paused = false
var room_coords := []
var map_coords := []
var characterSpawn = null
var enemySpawn = null
var partyList := []
var partySpawnList := []
var playerLevel = null
var shieldSpawn = null
var potionSpawn = null
var swordSpawn = null
var speedSpawn = null
var chestSpawn = null
var item= Globals.getItem()
#Happens when level loads
func _ready() -> void:
	_generate()
	character.tilemap = level
	playerLevel = Globals.getPlayerLevel()
	_setup_character()

# Called when the node enters the scene tree for the first time.
#Pause button
# warning-ignore:unused_argument
func _process(delta):
	if (Globals.getFlee()) :
		$HUD/hpBar.value = Globals.getPlayerHP()
		if Globals.get_party2MaxHP()!=null:
			$HUD/partyMember1/hpBar.value = Globals.get_party2HP()
		if Globals.get_party3MaxHP()!=null:
			$HUD/partyMember2/hpBar.value = Globals.get_party3HP()
		if Globals.get_party4MaxHP()!=null:
			$HUD/partyMember3/hpBar.value = Globals.get_party4HP()
		if Globals.get_party5MaxHP()!=null:
			$HUD/partyMember4/hpBar.value = Globals.get_party5HP()
		character.position = characterSpawn
		enemy.position = enemySpawn
		if partyList.size()>0:
			for i in range(partyList.size()):
				partyList[i].position = partySpawnList[i]
		Globals.setFlee(false)
	
	if Input.is_action_just_pressed('pause'):
		pauseMenu()
	if (Globals.getNextLevel()):
		nextLevel()
	if (Globals.getLost()):
		resetGlobals()
	
func resetGlobals():
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/Menu/Fortniters.tscn")
	#Level reset
	Globals.levelCount=1
	Globals.partyCount=0
	Globals.setPartyFull(false)
	#Player Reset
	Globals.setPlayerName("Adventurer")
	Globals.setPlayerHP(100)
	Globals.setPlayerMaxHP(100)
	Globals.setPlayerAttack(10)
	Globals.setPlayerDefense(5)
	Globals.setPlayerSpeed(37)
	Globals.setPlayerLevel(1)
	Globals.setPlayerExp(0)
	#Enemy Reset
	Globals.setEnemyName(null)
	Globals.setEnemyHP(null)
	Globals.setEnemyAttack(null)
	Globals.setEnemyDefense(null)
	Globals.setEnemySpeed(null)
	Globals.setEnemyExp(null)
	#Party Reset
	resetParty()
	#Set Lost back to false
	Globals.setLost(false)

func resetParty():
	Globals.set_party2Portrait(null)
	Globals.set_party2Name(null)
	Globals.set_party2HP(null)
	Globals.set_party2MaxHP(null)
	Globals.set_party2Attack(null)
	Globals.set_party2Defense(null)
	Globals.set_party2Speed(null)
	Globals.set_party2Level(null)
	Globals.set_party2Exp(null)
	
	Globals.set_party3Portrait(null)
	Globals.set_party3Name(null)
	Globals.set_party3HP(null)
	Globals.set_party3MaxHP(null)
	Globals.set_party3Attack(null)
	Globals.set_party3Defense(null)
	Globals.set_party3Speed(null)
	Globals.set_party3Level(null)
	Globals.set_party3Exp(null)
	
	Globals.set_party4Portrait(null)
	Globals.set_party4Name(null)
	Globals.set_party4HP(null)
	Globals.set_party4MaxHP(null)
	Globals.set_party4Attack(null)
	Globals.set_party4Defense(null)
	Globals.set_party4Speed(null)
	Globals.set_party4Level(null)
	Globals.set_party4Exp(null)
	
	Globals.set_party5Portrait(null)
	Globals.set_party5Name(null)
	Globals.set_party5HP(null)
	Globals.set_party5MaxHP(null)
	Globals.set_party5Attack(null)
	Globals.set_party5Defense(null)
	Globals.set_party5Speed(null)
	Globals.set_party5Level(null)
	Globals.set_party5Exp(null)
	#HUD Values
	$HUD/partyMember1.visible = false
	$HUD/partyMember2.visible = false
	$HUD/partyMember3.visible = false
	$HUD/partyMember4.visible = false
	
	$HUD/battleScene/partyMember2.visible = false
	$HUD/battleScene/partyMember2/p2HPBar.visible = false
	$HUD/battleScene/partyMember3.visible = false
	$HUD/battleScene/partyMember3/p3HPBar.visible = false
	$HUD/battleScene/partyMember4.visible = false
	$HUD/battleScene/partyMember4/p4HPBar.visible = false
	$HUD/battleScene/partyMember5.visible = false
	$HUD/battleScene/partyMember5/p5HPBar.visible = false

func nextLevel():
	Globals.setNextLevel(false)
	if playerLevel<Globals.getPlayerLevel():
		$HUD/hpBar.value = Globals.getPlayerMaxHP()
	if Globals.get_party2MaxHP()!=null:
		$HUD/partyMember1/hpBar.value = $HUD/partyMember1/hpBar.max_value
	if Globals.get_party3MaxHP()!=null:
		$HUD/partyMember2/hpBar.value = $HUD/partyMember2/hpBar.max_value
	if Globals.get_party4MaxHP()!=null:
		$HUD/partyMember3/hpBar.value = $HUD/partyMember3/hpBar.max_value
	if Globals.get_party5MaxHP()!=null:
		$HUD/partyMember4/hpBar.value = $HUD/partyMember4/hpBar.max_value
	_ready()
	
func random_number():
	# Initialize the random number generator
	randomize()
	# Return a random integer between 1 and 3
	return randi() % 5 + 1
#Initializes the player and enemy cahracters in the level
func _setup_character() -> void:
	enemy.visible = true
	Globals.setEnemyPortrait(enemyPortrait.texture)
	if Globals.getPartyCount() == 0:
		characterSpawn = level.map_to_world(Vector2(room_coords[0].x+6, room_coords[0].y+6)) #room center
		item = random_number()
		
		if(item == 1):
			Globals.setItem(item)
			shield.visible = true
			shieldSpawn = level.map_to_world(Vector2(room_coords[1].x+6, room_coords[1].y+6)) #room center
			shield.position = shieldSpawn
			#make all others invisible
			potion.visible = false
			sword.visible = false
			speed.visible = false
			chest.visible = false
		elif(item == 2):
			Globals.setItem(item)
			potion.visible = true
			potionSpawn = level.map_to_world(Vector2(room_coords[1].x+6, room_coords[1].y+6)) #room center
			potion.position = potionSpawn
			shield.visible = false
			sword.visible = false
			speed.visible = false
			chest.visible = false
		elif(item == 3):
			Globals.setItem(item)
			sword.visible = true
			swordSpawn = level.map_to_world(Vector2(room_coords[1].x+6, room_coords[1].y+6)) #room center
			sword.position = swordSpawn
			potion.visible = false
			shield.visible = false
			speed.visible = false
			chest.visible = false
		elif(item == 4):
			Globals.setItem(item)
			speed.visible = true
			speedSpawn = level.map_to_world(Vector2(room_coords[1].x+6, room_coords[1].y+6)) #room center
			speed.position = speedSpawn
			potion.visible = false
			shield.visible = false
			sword.visible = false
			chest.visible = false
		else:
			Globals.setItem(item)
			chest.visible = true
			chestSpawn = level.map_to_world(Vector2(room_coords[1].x+6, room_coords[1].y+6)) #room center
			chest.position = chestSpawn
			speed.visible = false
			potion.visible = false
			shield.visible = false
			sword.visible = false
			
		enemySpawn = level.map_to_world(Vector2(room_coords[4].x+6, room_coords[4].y+6)) #room center
		character.position = characterSpawn #put character in first room center
		enemy.position = enemySpawn #put enemy in random room center
		camera.position = character.position #attach camera to player
		print("Character spawned at: ", character.position)
		print("Potion spawned at: ", potion.position)
		print("Sword spawned at: ", sword.position)
		print("Shield spawned at: ", shield.position)
		print("Speed spawned at: ", speed.position)
	else:
		characterSpawn = level.map_to_world(Vector2(room_coords[0].x+5, room_coords[0].y+5)) #room center
		item = random_number()
		
		if(item == 1):
			Globals.setItem(item)
			shield.visible = true
			shieldSpawn = level.map_to_world(Vector2(room_coords[1].x+6, room_coords[1].y+6)) #room center
			shield.position = shieldSpawn
			potion.visible = false
			sword.visible = false
			speed.visible = false
			chest.visible = false
		elif(item == 2):
			Globals.setItem(item)
			potion.visible = true
			potionSpawn = level.map_to_world(Vector2(room_coords[1].x+6, room_coords[1].y+6)) #room center
			potion.position = potionSpawn
			shield.visible = false
			sword.visible = false
			speed.visible = false
			chest.visible = false
		elif(item == 3):
			Globals.setItem(item)
			sword.visible = true
			swordSpawn = level.map_to_world(Vector2(room_coords[1].x+6, room_coords[1].y+6)) #room center
			sword.position = swordSpawn
			potion.visible = false
			shield.visible = false
			speed.visible = false
			chest.visible = false
		elif(item == 4):
			Globals.setItem(item)
			speed.visible = true
			speedSpawn = level.map_to_world(Vector2(room_coords[1].x+6, room_coords[1].y+6)) #room center
			speed.position = speedSpawn
			potion.visible = false
			shield.visible = false
			sword.visible = false
			chest.visible = false
		else:
			Globals.setItem(item)
			chest.visible = true
			chestSpawn = level.map_to_world(Vector2(room_coords[1].x+6, room_coords[1].y+6)) #room center
			chest.position = chestSpawn
			speed.visible = false
			potion.visible = false
			shield.visible = false
			sword.visible = false
			
		enemySpawn = level.map_to_world(Vector2(room_coords[3].x+6, room_coords[3].y+6)) #room center
		character.position = characterSpawn #put character in first room center
		enemy.position = enemySpawn #put enemy in random room center
		camera.position = character.position #attach camera to player

		partyList = Globals.getPartyList()
		var tempList := []
		if partyList.size()<4 and Globals.getCapture():
			var partyMember = preload("res://Scenes/Levels/partyMember.tscn")
			var party = partyMember.instance()
			add_child(party)
			party.animationName = Globals.getEnemyName()
			party.partyPortrait = Globals.getEnemyPortrait()
			party.partyName = Globals.getEnemyName()
			party.partyHP = Globals.getEnemyHP()
			party.partyMaxHP = Globals.getEnemyHP()
			party.partyAttack = Globals.getEnemyAttack()
			party.partyDefense = Globals.getEnemyDefense()
			party.partySpeed = Globals.getEnemySpeed()
			party.partyLevel = Globals.getLevelCount()
			party.partyExp = 0
			Globals.appendPartyList(party)
			partyList = Globals.getPartyList()
			Globals.setCapture(false)
		for i in range(partyList.size()):
			var offset = 6+i
			var partySpawn = level.map_to_world(Vector2(room_coords[0].x+offset, room_coords[0].y+offset))
			partyList[i].position = partySpawn
			tempList.append(partySpawn)
		partySpawnList=tempList
	for i in len(enemies):
		if i!=enemyIndex:
			enemies[i].position = Vector2(0,0)
			enemies[i].visible = false

#Sets all tiles initially to wall tiles
func _set_background_tiles():
	var rng := RandomNumberGenerator.new()
	for x in range(level_size.x):
		for y in range(level_size.y):
			var index := rng.randi_range(0, 2)
			level.set_cellv(Vector2(x, y), TILE_OBSTACLE[index]) 

#Generates and sets actual level floor tiles in level space
func _generate(): 
	level.clear()
	room_coords = []
	_set_background_tiles()
	var ret := _generate_data()
	map_coords = ret

	var rng := RandomNumberGenerator.new()
	for vector in ret:
		var index := rng.randi_range(0, 2)
		level.set_cellv(vector, TILE_WALKABLE[index])  # Set walkable tile ID

#Generates to rooms and connections
func _generate_data() -> Array: 
	var rng := RandomNumberGenerator.new()
	rng.randomize()

	var data := {}
	var rooms := []
# warning-ignore:unused_variable
	for r in range(rooms_max):
		var room := _get_random_room(rng)
		if _intersects(rooms, room):
			continue
		
		_add_room(data, rooms, room)
		if rooms.size() > 1:
			var room_previous: Rect2 = rooms[-2]
			_add_connection(rng, data, room_previous, room)
	return data.keys()

#Creates room at random place within bounds of set size at top
func _get_random_room(rng: RandomNumberGenerator) -> Rect2:
# warning-ignore:narrowing_conversion
	var x := rng.randi_range(1, level_size.x - rooms_size.x - 2)
# warning-ignore:narrowing_conversion
	var y := rng.randi_range(1, level_size.y - rooms_size.y - 2)
	return Rect2(x, y, rooms_size.x, rooms_size.y)

#Adds a square room to level data
func _add_room(data: Dictionary, rooms: Array, room: Rect2) -> void:
	"""
	#Generates Square Rooms
	rooms.push_back(room)
	room_coords.append(Vector2(room.position.x, room.position.y))
	for x in range(room.position.x, room.end.x):
		for y in range(room.position.y, room.end.y):
			data[Vector2(x, y)] = null
	"""
	#Generates Poly-Shaped Rooms
	rooms.push_back(room)
	room_coords.append(Vector2(room.position.x, room.position.y))
	var rng = RandomNumberGenerator.new()
	if rng.randi_range(0, 1) == 0:
		for x in range(room.position.x, room.end.x):
			for y in range(room.position.y, room.end.y):
				data[Vector2(x, y)] = null
	else:
		var unit := FACTOR * room.size
		var order := [
			room.grow_individual(-unit.x, 0, -unit.x, unit.y - room.size.y),
			room.grow_individual(unit.x - room.size.x, -unit.y, 0, -unit.y),
			room.grow_individual(-unit.x, unit.y - room.size.y, -unit.x, 0),
			room.grow_individual(0, -unit.y, unit.x - room.size.x, -unit.y)
		]
		var poly := []
		for index in range(order.size()):
			var rect: Rect2 = order[index]
			var is_even := index % 2 == 0
			var poly_partial := []
# warning-ignore:unused_variable
			for r in range(rng.randi_range(1, 2)):
				poly_partial.push_back(Vector2(
					rng.randf_range(rect.position.x, rect.end.x),
					rng.randf_range(rect.position.y, rect.end.y)
				))
			poly_partial.sort_custom(self, "_lessv_x" if is_even else "_lessv_y")
			if index > 1:
				poly_partial.invert()
			poly += poly_partial
		
		for x in range(room.position.x, room.end.x):
			for y in range(room.position.y, room.end.y):
				var point := Vector2(x, y)
				if Geometry.is_point_in_polygon(point, poly):
					data[point] = null
	#"""

#Connects rooms with corridors from center to center
func _add_connection(
	rng: RandomNumberGenerator, data: Dictionary, room1: Rect2, room2: Rect2
) -> void:
	var room_center1 := (room1.position + room1.end) / 2
	var room_center2 := (room2.position + room2.end) / 2
	if rng.randi_range(0, 1) == 0:
# warning-ignore:narrowing_conversion
# warning-ignore:narrowing_conversion
# warning-ignore:narrowing_conversion
		_add_corridor(data, room_center1.x, room_center2.x, room_center1.y, Vector2.AXIS_X)
# warning-ignore:narrowing_conversion
# warning-ignore:narrowing_conversion
# warning-ignore:narrowing_conversion
		_add_corridor(data, room_center1.y, room_center2.y, room_center2.x, Vector2.AXIS_Y)
	else:
# warning-ignore:narrowing_conversion
# warning-ignore:narrowing_conversion
# warning-ignore:narrowing_conversion
		_add_corridor(data, room_center1.y, room_center2.y, room_center1.x, Vector2.AXIS_Y)
# warning-ignore:narrowing_conversion
# warning-ignore:narrowing_conversion
# warning-ignore:narrowing_conversion
		_add_corridor(data, room_center1.x, room_center2.x, room_center2.y, Vector2.AXIS_X)

#Sets the corridor tiles in the level
func _add_corridor(data: Dictionary, start: int, end: int, constant: int, axis: int) -> void:
	var corridor_width = 2
	var corridor_height = 2
	var rng := RandomNumberGenerator.new()

	for t in range(min(start, end), max(start, end) + 1):
		if axis == Vector2.AXIS_X:
			for offset in range((-corridor_width / 2), (corridor_width / 2)+1):
				data[Vector2(t, constant + offset)] = null
				var index := rng.randi_range(0, 2)
				level.set_cellv(Vector2(t, constant + offset), TILE_WALKABLE[index])  # Set walkable tile ID
		else:
			for offset in range((-corridor_height / 2), (corridor_height / 2)):
				data[Vector2(constant + offset, t)] = null
				var index := rng.randi_range(0, 2)
				level.set_cellv(Vector2(constant + offset, t), TILE_WALKABLE[index])  # Set walkable tile ID

#Checks if two rooms intersect, returns true if they do false otherwise
func _intersects(rooms: Array, room: Rect2) -> bool:
	var out := false
	for room_other in rooms:
		if room.intersects(room_other):
			out = true
			break
	return out

#helpers to compare vector coordinates
func _lessv_x(v1: Vector2, v2: Vector2) -> bool:
	return v1.x < v2.x

func _lessv_y(v1: Vector2, v2: Vector2) -> bool:
	return v1.y < v2.y

func pauseMenu():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
		
	paused = !paused
