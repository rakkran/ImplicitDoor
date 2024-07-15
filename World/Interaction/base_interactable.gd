extends Interactable
class_name BaseInteractable 

@export var prompt_text : String = "Press E to inspect."
@export var interact_text : Array[String] = [
	"Default inspect text goes here! I really have nothing more to add. Thanks for testing.",
	"You're still here? Awesome."
]

func _on_focused(_interactor):
	GameUi.set_prompt(prompt_text)

func _on_interacted(_interactor):
	GameUi.set_interact_text(interact_text.duplicate())

func _on_unfocused(_interactor):
	GameUi.remove_prompt()
