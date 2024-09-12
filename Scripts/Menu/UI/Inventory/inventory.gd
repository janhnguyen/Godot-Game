extends Node2D

const SlotClass = preload("res://Scripts/Menu/UI/Inventory/slot.gd")
onready var inventorySlots = $GridContainer
var holdingItem = null

func _ready():
	for invSlot in inventorySlots.get_children() :
		invSlot.connect("gui_input", self, "slot_gui_input", [invSlot])

func slot_gui_input(event: InputEvent, slot: SlotClass):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT && event.pressed:
			if holdingItem != null :
				if !slot.Item :
					slot.putIntoSlot(holdingItem)
					holdingItem = null
				else :
					var tempItem = slot.Item
					slot.pickFromSlot()
					tempItem.global_position = event.global_position
					slot.putIntoSlot(holdingItem)
					holdingItem = tempItem
			elif slot.Item :
				holdingItem = slot.Item
				slot.pickFromSlot()
				holdingItem.global_position = get_global_mouse_position()

# warning-ignore:unused_argument
func _input(event) :
	if holdingItem :
		holdingItem.global_position = get_global_mouse_position()
