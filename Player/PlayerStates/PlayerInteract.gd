extends PlayerState
class_name PlayerInteract


# Called when the node enters the scene tree for the first time.
func enter_state():
	super()
	state_machine.velocity.x = 0.0
	state_machine.velocity.z = 0.0
	state_machine.direction = Vector3.ZERO

func physics_update(delta):
	# Gravity & Jump
	if not state_machine.on_floor:
		velocity.y -= state_machine.gravity * delta

