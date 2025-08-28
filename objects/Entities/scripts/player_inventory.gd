extends Node

@onready var Items: Array[Item]

@export var Is_Open: bool = false

func _physics_process(delta) -> void:
	access()
	loot()

func access() -> void:
	if Input.is_action_just_released("inventory"): 
		Is_Open = Helpers.boolflip(Is_Open)
		get_parent().pause()
		
	if Is_Open:
		%InventoryScreen.visible = true
	else:
		%InventoryScreen.visible = false

func loot() -> void:
	var object = %PlayerLineOfSight.get_collider()
	if %PlayerLineOfSight.is_colliding() and object is Item:
		if object.Lootable: 
			%InteractLabel.text = "Loot"
			%InteractLabel.visible = true
			if Input.is_action_just_released("interact"):
				Helpers.store_item(object, Items, %ItemUI)
	else:
		if %InteractLabel.visible: %InteractLabel.visible = false
