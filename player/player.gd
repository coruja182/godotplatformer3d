class_name Player extends CharacterBody3D

var move_speed : float = 4.0
var jump_force : float = 8.0
var gravity : float = 20

var facing_angle : float

@onready var model: MeshInstance3D = $Model

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = jump_force
	
	var input = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	
	# calculate move direction
	var direction = Vector3(input.x, 0, input.y)
	
	# assign that direction to velocity
	velocity.x = direction.x * move_speed
	velocity.z = direction.z * move_speed

	move_and_slide()
	
	if input.length() > 0:
		facing_angle = Vector2(input.y, input.x).angle()

	model.rotation.y = lerp_angle(model.rotation.y, facing_angle, 0.5)
	
	if global_position.y < -5:
		game_over()


func game_over():
	get_tree().reload_current_scene()
	
#const SPEED = 5.0
#const JUMP_VELOCITY = 4.5

#func _physics_process(delta: float) -> void:
	## Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	#var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	#if direction:
		#velocity.x = direction.x * SPEED
		#velocity.z = direction.z * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
		#velocity.z = move_toward(velocity.z, 0, SPEED)
#
	#move_and_slide()
