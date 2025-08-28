class_name InventoryEntry extends Button

## The item stored in the entry
@onready var item: Item

func _init(x: Item) -> void:
	item = x
	self.text = item.Item_Name
	self.pressed.connect(_on_pressed)


func _on_pressed() -> void:
	print(item.Item_Name)
