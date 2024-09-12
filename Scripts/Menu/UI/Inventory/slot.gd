extends Panel

var ItemClass = preload("res://Scenes/Menu/UI/Items/Item.tscn")
var Item = null

func _ready():
	if randi() % 2 == 0 :
		Item = ItemClass.instance()
		add_child(Item)

func pickFromSlot():
	remove_child(Item)
	var inventoryNode = find_parent("inventory")
	inventoryNode.add_child(Item)
	Item = null
	
func putIntoSlot(newItem) :
	Item = newItem
	Item.position = Vector2(0, 0)
	var inventoryNode = find_parent("inventory")
	inventoryNode.remove_child(Item)
	add_child(Item)
