extends CharacterBody3D


signal hit

# How fast the player moves in meters per second
@export var speed = 14.0
# Vertical impulse applied to the character upon jumping in meters per second.
@export var jump_impulse = 20.0
# Vertical impulse applied to the character upon bouncing over a mob in meters per second.
@export var bounce_impulse = 8.0
# The downward acceleration while in the air, in meters per second squared.
@export var fall_acceleration = 75.0


func _physics_process(delta):
	get_velocity_from_input(delta)
	
	# Native func applying movement based on velocity
	move_and_slide()
	
	handle_collisions()
	

# Get the input direction and store it in the native velocity variable
func get_velocity_from_input(delta):
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
		$Pivot.look_at(direction + position)
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= fall_acceleration * delta
	else:
		# Handle jump.
		if Input.is_action_just_pressed("jump"):
			velocity.y = jump_impulse


func handle_collisions():
	# Iterate through all collisions that occurred this frame
	for index in range(get_slide_collision_count()):
		# We get one of the collisions with the player
		var collision = get_slide_collision(index)
		var collider = collision.get_collider()
		
		# If the collision is with ground
		if collider == null:
			continue

		# Detect if the player collided with a mob
		if collider.is_in_group("mobs"):
			# Detect if the collision happened from above
			if Vector3.UP.dot(collision.get_normal()) > 0.1:
				# If so, we squash it and bounce.
				collider.squash()
				velocity.y = bounce_impulse
				
				# Prevent further duplicate calls.
				break
	

func die():
	hit.emit()
	queue_free()


func _on_mob_detector_body_entered(body):
	print(body.name)	
	die()
