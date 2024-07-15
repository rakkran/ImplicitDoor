extends PlayerState
class_name PlayerWalk


func enter_state():
	super()
	target_speed = state_machine.WALK_SPEED

func physics_update(delta):
	input_dir = Input.get_vector("left","right","forward", "backward")
	
	# Gravity & Jump
	if not state_machine.on_floor:
		velocity.y -= state_machine.gravity * delta
	elif Input.is_action_just_pressed("jump"):
		velocity.y = state_machine.JUMP_VELOCITY
	
	# If current speed is less than min speed somehow, set it to min speed
	if current_speed < state_machine.WALK_SPEED:
		current_speed = state_machine.WALK_SPEED
	
	# Walking & Sprinting
	if Input.is_action_pressed("sprint"):
		target_speed = state_machine.SPRINT_SPEED
	else:
		target_speed = state_machine.WALK_SPEED
	
	# If current spead is less than target speed, instantly accelerate
	# Decelerate over time
	if current_speed < state_machine.WALK_SPEED:
		current_speed = state_machine.WALK_SPEED
	current_speed = lerp(current_speed, target_speed, delta * state_machine.lerp_speed)

	# Direction
	var target_direction = (state_machine.p_transform_basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if state_machine.on_floor:
		direction = lerp(direction, target_direction, state_machine.lerp_speed * delta)
	else:
		direction = lerp(direction, target_direction, state_machine.air_lerp_speed * delta)
	
	# Velocity
	if direction:
		velocity.x = direction.x * current_speed
		velocity.z = direction.z * current_speed
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed * delta)
		velocity.z = move_toward(velocity.z, 0, current_speed * delta)
	
	# Do stairs
	if direction:
		climb_stairs(delta)

## Function for stepping over small ledges/stairs.
func climb_stairs(delta):
	# First check to see if the player is running against a wall
	# Set rotation to match the direction player is moving
	var pointer_rot : Vector3 = Vector3(0, rad_to_deg(atan2(direction.x, direction.z)), 0)
	state_machine.foot_pointer.rotation_degrees = pointer_rot
	if state_machine.foot_pointer.is_colliding():
		# If the stair pointer isn't colliding, then the wall must be a ledge/stair step.
		state_machine.stair_pointer.rotation_degrees = pointer_rot
		if not state_machine.stair_pointer.is_colliding():
			state_machine.y_offset += 8 * delta
	
	# RESET
	state_machine.foot_pointer.rotation_degrees = Vector3.ZERO
	state_machine.stair_pointer.rotation_degrees = Vector3.ZERO               
	
		
	
	

