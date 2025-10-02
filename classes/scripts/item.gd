class_name Item extends RigidBody3D

## The name of the item
@export var Item_Name: String

## Whether or not the item is lootable if it exists in the world
@export var Lootable: bool

## The filepath to the item's inventory icon
@export var Inv_Icon: String

##The type of the item, used for player-facing info mostly
@export_enum("Trinket", "Melee Weapon") var Item_Type: String = "Trinket"
