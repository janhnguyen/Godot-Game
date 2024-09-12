extends Node


# Keeps track of the current game scene
var current_scene: Node = null


func _ready():
	current_scene = get_tree().current_scene

# Function to switch to a new scene
func switch_scene(scene_path: String):
	var new_scene = load(scene_path).instance()
	if is_instance_valid(current_scene):  # Check if the current scene is valid
		get_tree().root.remove_child(current_scene)
		current_scene.queue_free()
	else:
		print("Warning: current_scene was invalid or null.")
	get_tree().root.add_child(new_scene)
	get_tree().set_current_scene(new_scene)
	current_scene = new_scene  # Update the reference to the current scene  # Update the reference to the current scene

# Function to overlay a scene without removing the current one
func overlay_scene(scene_path: String):
	var overlay_resource = load(scene_path)
	if overlay_resource:
		var overlay_instance = overlay_resource.instance()
		# Assume add_child() is called on a node that should act as the parent for overlays, like a UI node
		add_child(overlay_instance)
	else:
		print("Failed to load overlay scene:", scene_path)

# Function to remove an overlay scene and return to the game
# Extended version of remove_overlay to optionally load a new overlay scene after removing the current one
func remove_overlay_by_name(overlay_name: String):
	var overlay = get_tree().get_root().find_node(overlay_name, true, false)
	if overlay:
		overlay.queue_free()
	else:
		print("Overlay with name", overlay_name, "not found.")
