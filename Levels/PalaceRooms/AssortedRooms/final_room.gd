extends "res://Levels/Level.gd"
var dialogue = ResourceLoader.load("res://World/Dialogue/Main.dialogue")

# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	GameUi.make_hud_invisible()
	GameUi.interact_speech_state = true
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	GameUi.remove_prompt()
	GameUi.change_player_state.emit("PlayerInteract")
	# Then, finally, show dialogue 
	DialogueManager.show_dialogue_balloon(dialogue, "interview_7")
