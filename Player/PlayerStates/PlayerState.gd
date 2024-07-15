extends Node
class_name PlayerState

var input_dir : Vector2 = Vector2.ZERO
var direction : Vector3 = Vector3.ZERO
var target_speed : float = 0.0

var current_jump_velocity : float = 0.0
var current_speed : float = 0.0
var velocity : Vector3 = Vector3.ZERO

# Signal for when changing state
signal Change_State

## Associated state machine
var state_machine : PlayerStateMachine

func set_state_machine(parent):
	state_machine = parent

## Checks the conditions for the state are still valid
func check_conditions():
	pass

func enter_state():
	pass

func exit_state():
	pass

#Equivalent of process
func update(_delta):
	pass

# Equivalent of physics_process
func physics_update(_delta):
	pass
