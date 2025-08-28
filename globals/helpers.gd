class_name Helpers

##Input a filepath for a resource and return it
static func loader(filepath: String) -> Resource:
	var x = load(filepath)
	return x
	

## Changes bool from true to false, and vice versa
static func boolflip(boolean: bool) -> bool:
	if boolean == true:
		return false
	else:
		return true

## Used for storing an item in an inventory
static func store_item(item: Item, inventory: Array[Item], ui: VBoxContainer) -> void:
	var copy = item.duplicate()
	var entry = preload("res://ui/InventoryEntry.tscn")
	var new_entry = entry.instantiate()
	new_entry.activate(copy)
	
	print(copy.Item_Name+" looted")
	ui.add_child(new_entry)
	inventory.append(copy)
	item.queue_free()

## Teleport an entity to a place
static func teleport(entity: Entity, coords: Vector3) -> void:
	entity.position = coords
