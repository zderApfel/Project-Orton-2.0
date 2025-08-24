extends Entity

var speed
const WALK_SPEED = 5.0
const SPRINT_SPEED = 8.0
const JUMP_VELOCITY = 4.8
const SENSITIVITY = 0.0015


#fov variables
const BASE_FOV = 75.0
const FOV_CHANGE = 1.5

#Footstep variables
const BOB_FREQ = 2.4
const BOB_AMP = 0.08
var t_step = 0.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

# Disables the camera aiming for using the mouse for other purposes
# Usually only happens when game is paused 
var camera_enabled: bool = true

@onready var head = $Head
@onready var camera = $Head/Camera3D


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _unhandled_input(event):
	if event is InputEventMouseMotion and camera_enabled:
		head.rotate_y(-event.relative.x * SENSITIVITY)
		camera.rotate_x(-event.relative.y * SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-60), deg_to_rad(75))


func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta

	if Input.is_action_just_pressed("jump_climb") and is_on_floor() and camera_enabled:
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_pressed("sprint"):
		speed = SPRINT_SPEED
	else:
		speed = WALK_SPEED

	# Get the input direction and handle the movement/deceleration.
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction = (head.transform.basis * transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if is_on_floor():
		if camera_enabled:
			if direction:
				velocity.x = direction.x * speed
				velocity.z = direction.z * speed
			else:
				velocity.x = lerp(velocity.x, direction.x * speed, delta * 7.0)
				velocity.z = lerp(velocity.z, direction.z * speed, delta * 7.0)
		else:
			velocity.x = 0
			velocity.z = 0
	else:
		velocity.x = lerp(velocity.x, direction.x * speed, delta * 3.0)
		velocity.z = lerp(velocity.z, direction.z * speed, delta * 3.0)

	var velocity_clamped = clamp(velocity.length(), 0.5, SPRINT_SPEED * 2)
	var target_fov = BASE_FOV + FOV_CHANGE * velocity_clamped
	camera.fov = lerp(camera.fov, target_fov, delta * 8.0)
	
	t_step += delta * velocity.length() * float(is_on_floor())
	camera.transform.origin = _footsteps(t_step)
	
	if Input.is_action_just_released("pause"): pause()
	move_and_slide()
		
func pause() -> void: 
	if Input.mouse_mode == 2:
		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	elif Input.mouse_mode == 3:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		
	camera_enabled = Helpers.boolflip(camera_enabled)	

func _footsteps(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * BOB_FREQ) * BOB_AMP
	pos.x = cos(time * BOB_FREQ / 2) * BOB_AMP
	return pos
