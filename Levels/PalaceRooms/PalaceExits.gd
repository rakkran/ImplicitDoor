class_name PalaceExit
extends Area3D

@export var properties : Dictionary

## Exits for the palace
## 
## Each one either goes through to the next room or back to the central hall.

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_body_entered)

# Called when the player enters 
func _on_body_entered(body):
	if body.name == "Player":
		SceneSwitcher.goto_room()

func update_properties() -> void:
	pass
