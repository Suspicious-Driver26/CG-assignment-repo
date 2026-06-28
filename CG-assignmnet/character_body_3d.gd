extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const MOUSE_SENSITIVITY = 0.1
const CAMERA_TILT_SPEED = 2.0
const MIN_TILT = deg_to_rad(-50)
const MAX_TILT = deg_to_rad(75)

@onready var camera_pivot: Node3D = $CameraPivot

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		var mouse_vel = Input.get_last_mouse_velocity()
		var new_rot_y = rotation.y - mouse_vel.x * delta * MOUSE_SENSITIVITY
		var new_rot_x = clampf(camera_pivot.rotation.x + mouse_vel.y * delta * MOUSE_SENSITIVITY, MIN_TILT, MAX_TILT)
		rotation.y = new_rot_y
		camera_pivot.rotation.x = new_rot_x

		if Input.is_action_just_pressed("ui_cancel"):
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		if Input.is_action_just_pressed("ui_cancel"):
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

	if Input.is_key_pressed(KEY_Q):
		rotate_y(-CAMERA_TILT_SPEED * delta)

	if Input.is_key_pressed(KEY_E):
		rotate_y(CAMERA_TILT_SPEED * delta)

	move_and_slide()
