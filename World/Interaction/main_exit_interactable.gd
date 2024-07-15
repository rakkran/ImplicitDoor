extends Interactable
class_name MainExitInteractable

@export var prompt_text : String = "Press E to exit the palace."

func _on_focused(interactor):
	if Global.main_dialogue_over:
		GameUi.set_prompt(prompt_text) # Replace with function body.

func _on_interacted(interactor):
	if Global.main_dialogue_over:
		GlobalAudioController.play_door_sfx()
		GameUi.remove_prompt()
		Global.goto_next_day()
	else: 
		pass
		#GameUi.set_interact_text(["Maybe you should speak to SCP-6462 before leaving."])
	
func _on_unfocused(interactor):
	GameUi.remove_prompt()
