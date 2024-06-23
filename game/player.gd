extends CharacterBody3D
@onready var pivot = $neck
@onready var camera = $neck/Camera3D
@onready var coins_group = get_tree().get_nodes_in_group("coins")
@onready var global = get_node("/root/Global")
var can_shoot = true
var double_jump = true
const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var sensitivity = 0.01
var total_coins = 0
var player_health = 100
var bullet = load("res://bullet.tscn")
var instance

# Proof
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
func _ready(): 
	for coins in coins_group:
		total_coins += 1
	total_coins = len(coins_group)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
func _take_damage():
	player_health -= 10
func shoot():
	$neck/Camera3D/AnimationPlayer.play("shoot")
	$"../Shoot_timer".start(0.1)
	can_shoot = false
	instance = bullet.instantiate()
	instance.position = $neck/gun.global_position
	instance.transform.basis = $neck/gun.global_transform.basis
	get_parent().add_child(instance)
	
func _unhandled_input(event): 
	if event is InputEventMouseMotion:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			pivot.rotate_y(-event.relative.x * sensitivity / 2)
			camera.rotate_x(-event.relative.y * sensitivity / 4)
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-90), deg_to_rad(90))
			camera.rotation.y = clamp(camera.rotation.y, deg_to_rad(0), deg_to_rad(0))
func _physics_process(delta):
	# Add the gravity.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (pivot.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

	if Input.is_action_pressed("left_click") and can_shoot == true:
		shoot()
		
	

func _on_shoot_timer_timeout():
	can_shoot = true
