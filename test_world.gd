extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	death_barrier()

func death_barrier() -> void:
	if $Player.position.y <= -20:
		Helpers.teleport($Player, Vector3(0,1,0))
