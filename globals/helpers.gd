class_name Helpers

## Changes bool from true to false, and vice versa
static func boolflip(boolean: bool) -> bool:
	if boolean == true:
		return false
	else:
		return true

static func store_item(item: Item, inventory: Inventory) -> void:
	var copy = item.duplicate()
	print(copy.Item_Name+" looted")
	inventory.Items.append(copy)
	item.queue_free()
