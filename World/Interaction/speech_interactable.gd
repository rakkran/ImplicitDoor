extends Interactable
class_name SpeechInteractable 

@export var dialogue_resource : DialogueResource
@export var dialogue_start : String = "start"
@export var prompt_text : String = "Interview SCP-6462-C-1"

func _ready():
	DialogueManager.dialogue_ended.connect(_on_dialogue_ending)

func _on_focused(_interactor):
	if not GameUi.interact_speech_state:
		GameUi.set_prompt(prompt_text) 

func _on_interacted(_interactor):
	if not GameUi.interact_speech_state:
		GameUi.make_hud_invisible()
		GameUi.interact_speech_state = true
		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
		GameUi.remove_prompt()
		GameUi.change_player_state.emit("PlayerInteract")
		# Then, finally, show dialogue 
		DialogueManager.show_dialogue_balloon(dialogue_resource, dialogue_start)

func _on_dialogue_ending(_speech_resource : DialogueResource):
	GameUi.make_hud_visible()
	GameUi.interact_speech_state = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	GameUi.change_player_state.emit("PlayerWalk")

func _on_unfocused(_interactor):
	GameUi.remove_prompt()
