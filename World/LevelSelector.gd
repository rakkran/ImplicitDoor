## Handles switching between rooms in the palace
## 
extends Node
class_name LevelSelect

## Bool used for avoiding duplicate teleports
var changing_room : bool = false

## World & player node 
var world_node : Node3D
var player_node : Player
var player_spawn_point : Node3D

## entered_central_hall : Signal called when the central hall is entered 
signal entered_central_hall

## all_rooms : Holds the path to the scene containing every room in the palace 
## current_scene : The current active scene (assumes the world scene is always active for now) 
var all_rooms : Array[String] = ["res://Levels/PalaceRooms/AssortedRooms/TestRoom1.tscn", "res://Levels/PalaceRooms/AssortedRooms/TestRoom2.tscn"]
var current_scene : Node3D 

## palace_rooms : 6 other palace rooms that the player accesses when passing through central hall doors
##                generated when when the central hall scene is instantiated 
## explored_rooms : The rooms that have been visited so far
var palace_rooms : Array[String] = []
var explored_rooms : Array[String] = []

func _ready():
	entered_central_hall.connect(_on_entering_central_hall)
	goto_central_hall()

## Function for transitioning to a new scene
func goto_scene(path):
	# Calling deferred to let current scene finish whatever its doing
	call_deferred("_deferred_goto_scene", path)

func _deferred_goto_scene(path):
	#It's now safe to remove the current scene
	if current_scene:
		current_scene.free()
	
	#Load the new scene
	var s = ResourceLoader.load(path)
	
	#Instantiate
	current_scene = s.instantiate()
	
	#Add it as a child of world 
	world_node.add_child(current_scene)
	
	#Set player position 
	player_node.global_position = player_spawn_point.global_position
	player_node.global_rotation = player_spawn_point.global_rotation
	
	#Allow rooms to be changed again 
	changing_room = false

## Functions for entering, leaving, and returning to central hall
## Leaving 
func goto_next_room():
	# If all areas have been explored return to central hall
	if palace_rooms.is_empty():
		print("palace rooms are all explored!")
		goto_central_hall()
	elif not changing_room:
		changing_room = true
		var temp = palace_rooms.pop_front()
		print(temp)
		explored_rooms.append(temp)
		goto_scene(temp)

# This is its own function to allow me to send the player back to central hall when necessary
func goto_central_hall():
	goto_scene("res://Levels/PalaceRooms/central_hall.tscn")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

## Generate the new set of 7 rooms
func _on_entering_central_hall():
	print("Generating palace rooms!")
	# Clear any previously explored rooms
	explored_rooms.clear()
	palace_rooms.clear()
	for i in range(6):
		var temp_room : String = all_rooms.pick_random()
		# Keep picking a random room untill its all you 
		#while palace_rooms.has(temp_room):
			#temp_room = all_rooms.pick_random()
		palace_rooms.append(temp_room)
	print(palace_rooms)
	
