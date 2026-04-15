extends CharacterBody3D

# Field Command — third-person character controller (prototype 0.2)
# WASD move relative to camera. Mouse look. Space jump. Shift run. Esc releases cursor.

const WALK_SPEED: float = 5.0
const RUN_SPEED: float = 8.5
const JUMP_VELOCITY: float = 5.5
const GRAVITY: float = 18.0
const MOUSE_SENSITIVITY: float = 0.003
const PITCH_MIN: float = -1.2  # ~ -68 deg
const PITCH_MAX: float = 0.6   # ~ +34 deg (looking slightly up, not straight up)
const TURN_SPEED: float = 12.0 # body rotation lerp speed

@onready var camera_rig: Node3D = $CameraRig
@onready var pitch_node: Node3D = $CameraRig/Pitch
@onready var mesh_pivot: Node3D = $MeshPivot


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	print("[Field Command] third-person prototype 0.2")
	print("[Field Command] WASD move  //  Shift run  //  Space jump  //  Mouse look  //  Esc release cursor")


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		camera_rig.rotate_y(-event.relative.x * MOUSE_SENSITIVITY)
		pitch_node.rotate_x(-event.relative.y * MOUSE_SENSITIVITY)
		pitch_node.rotation.x = clamp(pitch_node.rotation.x, PITCH_MIN, PITCH_MAX)
	elif event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE:
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	elif event is InputEventMouseButton and event.pressed and Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _physics_process(delta: float) -> void:
	# Gravity
	if not is_on_floor():
		velocity.y -= GRAVITY * delta

	# Jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# WASD input — y axis is forward/back, x is strafe
	var input_dir: Vector2 = Vector2.ZERO
	if Input.is_key_pressed(KEY_W): input_dir.y += 1.0
	if Input.is_key_pressed(KEY_S): input_dir.y -= 1.0
	if Input.is_key_pressed(KEY_A): input_dir.x -= 1.0
	if Input.is_key_pressed(KEY_D): input_dir.x += 1.0

	var speed: float = RUN_SPEED if Input.is_key_pressed(KEY_SHIFT) else WALK_SPEED

	if input_dir.length() > 0.01:
		input_dir = input_dir.normalized()
		# Camera-relative movement on the horizontal plane
		var basis: Basis = camera_rig.global_transform.basis
		var forward: Vector3 = -basis.z
		forward.y = 0.0
		forward = forward.normalized()
		var right: Vector3 = basis.x
		right.y = 0.0
		right = right.normalized()
		var move_dir: Vector3 = (right * input_dir.x + forward * input_dir.y).normalized()
		velocity.x = move_dir.x * speed
		velocity.z = move_dir.z * speed
		# Turn the visible body toward movement direction
		var target_rot: float = atan2(move_dir.x, move_dir.z)
		mesh_pivot.rotation.y = lerp_angle(mesh_pivot.rotation.y, target_rot, TURN_SPEED * delta)
	else:
		velocity.x = move_toward(velocity.x, 0.0, speed)
		velocity.z = move_toward(velocity.z, 0.0, speed)

	move_and_slide()
