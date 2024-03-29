extends CharacterBody3D


# Emitted when the player jumped on the mob
signal squashed

# Minimum speed of the mob in meters per second.
@export var min_speed = 10.0
# Maximum speed of the mob in meters per second.
@export var max_speed = 18.0


func _physics_process(delta):
	move_and_slide()


func _on_visible_on_screen_notifier_3d_screen_exited():
	queue_free()


# This function will be called from the Main scene.
func initialize(start_position, player_position):
	# We position the mob by placing it at start_position
	# and rotate it towards player_position, so it looks at the player.
	look_at_from_position(start_position, player_position)
	# Rotate this mob randomly within range of -45 and +45 degrees,
	# so that it doesn't move directly towards the player.
	rotate_y(randf_range(-PI / 4, PI / 4))
	
	# We generate a random speed (integer)
	var random_speed = randi_range(min_speed, max_speed)
	# We calculate a forward velocity that represents the speed.
	velocity = Vector3.FORWARD * random_speed
	# We then rotate the velocity vector based on the mob's Y rotation
	# in order to move in the direction the mob is looking.
	velocity = velocity.rotated(Vector3.UP, rotation.y)

	# Adjust animation based on mob's speed
	$AnimationPlayer.speed_scale = random_speed / min_speed
	
func squash():
	squashed.emit()
	queue_free()
