## Generic level script for the palace rooms, needs to hold the player spawn location 
extends Node3D
class_name Level

var player_spawn_object : Node3D 
func _ready():
	for child in get_children():
		if child is QodotMap:
			get_player_spawn(child)

func get_player_spawn(map_node : QodotMap):
	for child in map_node.get_children():
		if child.get("properties"):
			if child.properties["classname"] == "PlayerSpawn":
				player_spawn_object = child

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
