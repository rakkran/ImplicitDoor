extends Interactable
class_name DoorInteractable

@export var prompt_text : String = ""
@export var next_scene_path : String 

func _on_focused(interactor):
	GameUi.set_prompt(prompt_text) # Replace with function body.

func _on_interacted(interactor):
	GlobalAudioController.play_door_sfx()
	SceneSwitcher.switch_scene(next_scene_path)
	GameUi.remove_prompt()

func _on_unfocused(interactor):
	GameUi.remove_prompt()
