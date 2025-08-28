class_name Helpers

## Changes bool from true to false, and vice versa
static func boolflip(boolean: bool) -> bool:
	if boolean == true:
		return false
	else:
		return true

static func store_item(item: Item, inventory: Array[Item], ui: VBoxContainer) -> void:
	var copy = item.duplicate()
	print(copy.Item_Name+" looted")
	var new_entry = InventoryEntry.new(copy)
	ui.add_child(InventoryEntry.new(copy))
	inventory.append(copy)
	item.queue_free()
