extends Area3D
class_name Interactable


# Emitted when an Interactor starts looking at me
signal focused(interactor : Interactable)
# Emitted when an Interactor stops looking at me 
signal unfocused(interactor : Interactable)
#Emitted when an interactor interacts interacts with me 
signal interacted(interactor : Interactable)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
