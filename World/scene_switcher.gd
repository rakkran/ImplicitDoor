extends Node

#When going from throne room to central hall, we use a different teleport location 
var last_room_throne_room : bool = false
const throne_room_player_spawn = Vector3(-0.5, -5.5, -34.5)

var scene_timer_finished : bool = true
var scene_timer : float = 0.0 
# Player node and related signals
var player_node : Player = preload("res://Player/player.tscn").instantiate()

# Palace room variables
const CENTRAL_HALL_PATH : String = "res://Levels/PalaceRooms/central_hall.tscn"
var palace_rooms : Array[String] = []
const ROOMS_PREFIX : String = "res://Levels/PalaceRooms/AssortedRooms/"
const ALL_ROOMS : Array[String] = [
	#ROOMS_PREFIX + "TestRoom1.tscn",
	#ROOMS_PREFIX + "TestRoom2.tscn",
	ROOMS_PREFIX + "library.tscn",
	ROOMS_PREFIX + "empty_chamber.tscn"
]
# Max number of rooms before returning to central hall
const MAX_ROOM_NUMBER : int = 7

var current_scene : Level = null
func _ready() -> void:
	initial_setup()
	Global._initial_setup()

func initial_setup():
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)
	current_scene.add_child(player_node)
	player_node.position = Vector3(-0.5,-5.5,34.5)
	player_node.rotation = Vector3.ZERO
	generate_palace_rooms()


func _physics_process(delta):
	if not scene_timer_finished:
		scene_timer += delta
	if scene_timer >= 3.0:
		scene_timer_finished = true
		scene_timer = 0.0
		

func switch_scene(res_path):
	if scene_timer_finished:
		scene_timer_finished = false
		call_deferred("_switch_scene_transition", res_path)

func _switch_scene_transition(res_path):
	GameUi.scene_transition_effect(res_path)

func _deferred_switch_scene(res_path):
	if current_scene.name == "ThroneRoom" and res_path == "res://Levels/PalaceRooms/central_hall.tscn":
		last_room_throne_room = true
	else:
		last_room_throne_room = false
	# Remove player node from node 
	current_scene.remove_child(player_node)
	current_scene.free()
	var s = load(res_path)
	current_scene = s.instantiate()
	get_tree().root.add_child(current_scene)
	get_tree().current_scene = current_scene
	set_player_pos()

func generate_palace_rooms():
	palace_rooms.clear()  # Clear any current rooms generated
	for i in range(MAX_ROOM_NUMBER):
		var temp_path : String = ALL_ROOMS.pick_random()
		# Insert checks for duplicates
		palace_rooms.append(temp_path)

func goto_room():
	# If the rooms have been visited, return to central hall
	if palace_rooms.is_empty():
		switch_scene(CENTRAL_HALL_PATH)
	else:
		if scene_timer_finished:
			var temp_path : String = palace_rooms.pop_back()
			switch_scene(temp_path)

## PLAYER FUNCTIONS

func set_player_pos():
	# Sets player position/rotation, etc. 
	if last_room_throne_room:
		player_node.position = throne_room_player_spawn
	else:
		player_node.position = current_scene.player_spawn_object.position
		player_node.rotation = current_scene.player_spawn_object.rotation
	current_scene.add_child(player_node)

func _change_player_state(new_state):
	var player_current_state = player_node.state_machine.current_state
	player_node.state_machine._on_change_state(player_current_state, new_state)
	
	


