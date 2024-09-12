extends KinematicBody2D

var textureList = [] 
var speed = 35
var player = null
var party = null
var tileMap = null
var map_coords = null
var animationName = null
var partyPortrait = null
var partyName = null
var partyHP = null
var partyMaxHP = null
var partyAttack = null
var partyDefense = null
var partySpeed = null
var partyLevel = null
var partyExp = null

func _physics_process(_delta):
	if party:
		map_coords = get_parent().map_coords
		if player.moving:
			var level_coord = tileMap.world_to_map(position)
			var player_coord = tileMap.world_to_map(player.position)
			if level_coord in map_coords:
				$AnimatedSprite.play(animationName)
				position += (player.position - position)/speed
			else:
				#print(get_node("."))
				#Check the nearest valid tile in the direction of the player??
				if player.direction==Vector2(1,0):
					#print("Right")
					var mapTemp = Vector2(player_coord.x-2, player_coord.y)
					var worldTemp = tileMap.map_to_world(mapTemp)
					position = Vector2(worldTemp.x+7, worldTemp.y+7)
				elif player.direction==Vector2(-1,0):
					#print("Left")
					var mapTemp = Vector2(player_coord.x+2, player_coord.y)
					var worldTemp = tileMap.map_to_world(mapTemp)
					position = Vector2(worldTemp.x+7, worldTemp.y+7)
				elif player.direction==Vector2(0,1):
					#print("Down")
					var mapTemp = Vector2(player_coord.x, player_coord.y-2)
					var worldTemp = tileMap.map_to_world(mapTemp)
					position = Vector2(worldTemp.x+7, worldTemp.y+7)
				elif player.direction==Vector2(0,-1):
					#print("Up")
					var mapTemp = Vector2(player_coord.x, player_coord.y+2)
					var worldTemp = tileMap.map_to_world(mapTemp)
					position = Vector2(worldTemp.x+7, worldTemp.y+7)
				elif player.direction==Vector2(-0.707107, -0.707107):
					#print("Up and Left")
					var mapTemp = Vector2(player_coord.x+2, player_coord.y+2)
					var worldTemp = tileMap.map_to_world(mapTemp)
					position = Vector2(worldTemp.x+7, worldTemp.y+7)
				elif player.direction==Vector2(0.707107, -0.707107):
					#print("Up and Right")
					var mapTemp = Vector2(player_coord.x-2, player_coord.y+2)
					var worldTemp = tileMap.map_to_world(mapTemp)
					position = Vector2(worldTemp.x+7, worldTemp.y+7)
				elif player.direction==Vector2(-0.707107, 0.707107):
					#print("Down and Left")
					var mapTemp = Vector2(player_coord.x+2, player_coord.y-2)
					var worldTemp = tileMap.map_to_world(mapTemp)
					position = Vector2(worldTemp.x+7, worldTemp.y+7)
				else: #(0.707107, 0.707107)
					#print("Down and Right")
					var mapTemp = Vector2(player_coord.x-2, player_coord.y-2)
					var worldTemp = tileMap.map_to_world(mapTemp)
					position = Vector2(worldTemp.x+7, worldTemp.y+7)
		else:
			$AnimatedSprite.play(animationName)
	else:
		pass

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent().get_child(8)
	#print(get_parent().get_children())
	tileMap = get_parent().get_child(2)
	#map_coords = get_parent().map_coords
	#print(map_coords.size())
	if Globals.getPartyCount() > 0:
		party=true
