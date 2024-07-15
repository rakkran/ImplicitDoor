extends CharacterBody3D
class_name Player
# Player nodes

@onready var neck = $Neck
@onready var head = $Neck/Head
@onready var camera = $Neck/Head/Camera3D
@onready var standing_collision_shape = $StandingCollisionShape
@onready var state_machine : PlayerStateMachine = $StateMachine
@onready var footstep_player = $FootstepPlayer
@onready var footstep_timer = $FootstepTimer

var velocity_clamped = 0.0
var mouse_sens = 0.1
var target_fov = 0

func _input(event):
	# Camera Rotation using mouse
	if event is InputEventMouseMotion and not GameUi.interact_speech_state:
		rotate_y(deg_to_rad(-event.relative.x * mouse_sens))
		head.rotate_x(deg_to_rad(-event.relative.y * mouse_sens))
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-89), deg_to_rad(89))
		
		
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	state_machine.get_player_values(transform.basis)
	state_machine.velocity = velocity
	state_machine.on_floor = is_on_floor()
	state_machine.on_wall = is_on_wall()

func _physics_process(delta):
	# Get values from state machine
	velocity = state_machine.velocity
	# Move
	move_and_slide()
	# Apply y offset
	global_position.y += state_machine.y_offset
	
	# Set values into state machine 
	state_machine.get_player_values(transform.basis)
	state_machine.velocity = velocity
	state_machine.on_floor = is_on_floor()
	state_machine.on_wall = is_on_wall()
	state_machine.y_offset = 0
	
	# Play footstep
	play_footstep()

func play_footstep():
	if velocity.length() >= 0.8 and footstep_timer.is_stopped() and is_on_floor():
		footstep_player.pitch_scale = randf_range(0.8,1.2)
		footstep_player.play()
		footstep_timer.start()
	
