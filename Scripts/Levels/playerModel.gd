extends KinematicBody2D

const SPEED = 15
const TILE_WALKABLE := 1
const TILE_OBSTACLE := 0

var tilemap: TileMap
var moving = null
var direction = Vector2.ZERO

# warning-ignore:unused_argument
func _physics_process(delta):
	var velocity = Vector2.ZERO
	
	# Check for input and update velocity accordingly
	if Input.is_key_pressed(KEY_D):
		velocity.x += 1
	if Input.is_key_pressed(KEY_A):
		velocity.x -= 1
	if Input.is_key_pressed(KEY_S):
		velocity.y += 1
	if Input.is_key_pressed(KEY_W):
		velocity.y -= 1
		
	# Normalize velocity if moving diagonally
	if velocity.length_squared() > 0:
		velocity = velocity.normalized()
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * SPEED
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	
	if velocity.x != 0 || velocity.y != 0:
		moving = true
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.flip_h = velocity.x < 0
		direction = velocity.normalized()

	if velocity.x == 0 && velocity.y == 0:
		moving = false
		$AnimatedSprite.animation = "idle"
	
	
	# Move the KinematicBody2D
# warning-ignore:return_value_discarded
	move_and_slide(velocity * SPEED)
