extends SpeechInteractable
class_name CasketInteractable

# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	dialogue_start = Global.current_main_dialogue
	Global.day_dialogue_over.connect(_on_day_dialogue_over)

func _on_day_dialogue_over(new_start):
	Global.current_main_dialogue = new_start
	Global.main_dialogue_over = true 
	dialogue_start = new_start
	GameUi.set_objective(Global.objective)
	GameUi.set_sub_objective(Global.sub_objectives)
	
