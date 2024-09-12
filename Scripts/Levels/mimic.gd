extends KinematicBody2D

# Declare member variables here. Examples:
var velocity = Vector2.ZERO
var player_chase = false
var player = null
var combat = false
var tempPos = null
var state = IDLE

export var ACCELERATION = 300
export var MAX_SPEED = 50
export var FRICTION = 200
export var WANDER_TARGET_RANGE = 4

enum {
	IDLE
}

onready var playerNode = get_parent().get_child(8)

#combat variables

var enemyName = "Mimic"
var enemyHP =  20
var enemyAttack = 3
var enemyDefense = 2
var enemySpeed = 27
var giveExp = 15

func _physics_process(delta):
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

#fix this garbage later
func _on_combat_detection_area_body_entered(body):
	if ("player" in str(body)) :
		Engine.time_scale = 0
		player_chase = false
		Globals.setEnemyPortrait($portrait.texture)
		Globals.setEnemyName(enemyName)
		Globals.setEnemyHP(enemyHP)
		Globals.setEnemyAttack(enemyAttack)
		Globals.setEnemyDefense(enemyDefense)
		Globals.setEnemySpeed(enemySpeed)
		Globals.setEnemyExp(giveExp)
		Globals.setCombat(true)
	
func _on_combat_detection_area_body_exited(_body):
	Engine.time_scale = 1
	Globals.setCombat(false)

