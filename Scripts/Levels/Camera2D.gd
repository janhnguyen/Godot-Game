extends Camera2D

# Reference to the player character (assuming it's a child of the same parent node as the camera)
onready var player = get_parent().get_node("playerModel")

# Camera offset from the player
const CAMERA_OFFSET = Vector2(0, 0)
const ZOOM_FACTOR = Vector2(0.5, 0.5)

# warning-ignore:unused_argument
func _process(delta):
	# Set the camera position to follow the player
	position = player.global_position + CAMERA_OFFSET
	zoom = ZOOM_FACTOR
