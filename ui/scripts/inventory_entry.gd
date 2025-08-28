class_name InventoryEntry extends Button

## The item stored in the entry. Has to be lowercase due to my dumb naming conventions
@onready var item: Item


func _physics_process(delta) -> void:
	pass

func activate(x: Item) -> void:
	item = x
	self.text = item.Item_Name
	if item.Inv_Icon != null: $Icon.texture = load(item.Inv_Icon)
	
func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_released("primary_action"):
		print(item.Item_Name)
