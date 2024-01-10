extends CharacterBody3D


@export var speed = 10.0
@export var jump_velocity = 5.0
@export var bounce_impulse = 4.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity : int = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta):
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
		$Pivot.look_at(direction + transform.origin)
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()
	
	# Handling collisions
	for index in range(get_slide_collision_count()):
		var collision = get_slide_collision(index)
		var collider = collision.get_collider()
		
		# Detect is the player collided with a mob
		if collider.is_in_group("mobs"):
			# Detect if the collision happened from above
			if Vector3.UP.dot(collision.get_normal()) > 0.1 :
				collider.squash()
				velocity.y = bounce_impulse
	
