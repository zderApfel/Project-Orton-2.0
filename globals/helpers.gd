class_name Helpers extends Node

## Changes bool from true to false, and vice versa
static func boolflip(boolean: bool) -> bool:
	if boolean == true:
		return false
	else:
		return true

## item is the item to be dropped
## ui_element is the ui for the item in the inventory it is being removed from
static func drop_item(item: Item, ui_element: InventoryEntry) -> void:
	var copy = item.duplicate()
	var drop_point = get_world(ui_element, "World/Player/Head/DropPoint")
	
	copy.position = drop_point.global_position
	get_world(ui_element,"World").add_child(copy)

	ui_element.queue_free()
	item.queue_free()
	
## Returns the world environment
## SELF is a node that acts as a sort of "gateway" to the world node
## Used for handling spawning in objects into the world	
## Function doesn't work if the root of a world isn't named "World" lmao
## Alternatively, you can use the optional parameter node_path to reparent differently
static func get_world(SELF: Node, node_path: String = "World") -> Node:
	return SELF.get_tree().get_root().get_node(node_path)	

##Input a filepath for a resource and return it
static func loader(filepath: String) -> Resource:
	var x = load(filepath)
	return x
	
## Used for storing an item in an inventory.
## <item> is the item itself. 
## <inventory> is the array where the items are stored.
## <ui> is the UI assigned to the inventory, for interaction from players
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
