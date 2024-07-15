# Displays a prompt ("e.g. Press E to Read") when an interactable is focused. 
extends RichTextLabel
class_name InteractionPrompt 

# Called when the node enters the scene tree for the first time.
func _ready():
	text = ""
	
func set_new_prompt(prompt : String):
	text = prompt

func reset_prompt():
	text = ""
