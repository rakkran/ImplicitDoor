extends Node
class_name PlayerStateMachine

@export var initial_state : PlayerState
var current_state : PlayerState
var states : Dictionary = {}

#### Player values
## Player raycasts
@onready var foot_pointer : RayCast3D = $"../Pointers/FootPointer"
@onready var stair_pointer : RayCast3D = $"../Pointers/StairCheck"
## Transform basis
var p_transform_basis : Basis
var y_offset : float = 0.0
## Player attributes
var on_floor : bool = false
var on_wall : bool = false

###### Moveme
## Directional control
var input_dir : Vector2 = Vector2.ZERO
var direction : Vector3 = Vector3.ZERO

## Speed values
var velocity : Vector3 = Vector3.ZERO
var current_speed : float = 10.0
var current_jump_velocity : float = 0.0
const WALK_SPEED : float = 10.0
const SPRINT_SPEED : float = 14.0
const JUMP_VELOCITY : float = 8.0

## Lerp/Friction values
var lerp_speed : float = 10.0
var air_lerp_speed : float = 3.0

## Gravity
var gravity : float = 19.6




## Sets up all available states.
## States are represented as child nodes of the state machine.
func _ready():
	for child in get_children():
		if child is PlayerState:
			# Make name lowercase for consistency
			states[child.name.to_lower()] = child
			child.Change_State.connect(_on_change_state)
			child.set_state_machine(self)
		if initial_state:
			initial_state.enter_state()
			current_state = initial_state


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current_state:
		current_state.update(delta)

func _physics_process(delta):
	if current_state:
		set_state_values()
		current_state.physics_update(delta)
		get_state_values()
		current_state.check_conditions()

func _on_change_state(state : PlayerState, new_state_name : String):
	# Ensure that the current state is the one changing
	if state != current_state:
		return
	
	var new_state = states.get(new_state_name.to_lower())
	# Checking if new state exists
	if !new_state:
		return
	
	# If there is a current state, exit it
	if current_state:
		current_state.exit_state()
	new_state.enter_state()
	current_state = new_state

## Get values from the player 
func get_player_values(player_transform_basis):
	p_transform_basis = player_transform_basis

## Pass values to current state
func set_state_values():
	current_state.velocity = velocity

## Get values from the current state
func get_state_values():
	velocity = current_state.velocity
	
