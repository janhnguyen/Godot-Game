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
	IDLE,
	WANDER,
	CHASE
}

onready var playerDetectionZone = $PlayerDetectionZone
onready var wanderController = $WanderController
onready var playerNode = get_parent().get_child(4)

#combat variables

var enemyName = "Wraith"
var enemyHP =  20
var enemyAttack = 3
var enemyDefense = 2
var enemySpeed = 27
var giveExp = 15

func _physics_process(delta):
	$AnimatedSprite.play("idle")
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			seek_player()
			
			if wanderController.get_time_left() == 0:
				state = pick_random_state([IDLE,WANDER])
				wanderController.start_wander_timer(rand_range(1, 3))
		WANDER:
			seek_player()
			if wanderController.get_time_left() == 0:
				state = pick_random_state([IDLE,WANDER])
				wanderController.start_wander_timer(rand_range(1, 3))
			
			var direction = position.direction_to(playerNode.position)
			
			velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
			
			if position.distance_to(playerNode.position) <= WANDER_TARGET_RANGE:
				# warning-ignore:standalone_expression
				state - pick_random_state([IDLE, WANDER])
				wanderController.start_wander_timer(rand_range(1, 3))
			
		CHASE:
			# warning-ignore:shadowed_variable
			var player = playerDetectionZone.player
			if player != null:
				var direction = global_position.direction_to(player.global_position)
				velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
			else:
				state = IDLE
	
	velocity = move_and_slide(velocity)

func seek_player():
	if playerDetectionZone.can_see_player():
		state = CHASE

func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()

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
