extends Node

# OVERALL GAME STUFF
var main_menu = preload("res://UI/Menus/main_menu.tscn").instantiate()
var opening_scene = preload("res://UI/Menus/opening.tscn").instantiate()

# DIALOGUE
const ALL_DIALOGUE : Array[String] = [
	"interview_1",
	"interview_2",
	"interview_3",
	"interview_4",
	"interview_5",
	"interview_6",
	"interview_7"
]
const ALL_OBJECTIVES :  Array[String] =[
	"Enter the throne room to meet SCP-6462-C-1.",
	"Return to the throne room to conduct your second interview with SCP-6462-C-1.",
	"Return to the throne room to conduct your third interview with SCP-6462-C-1.",
	"Return to the throne room to conduct your fourth interview with SCP-6462-C-1.",
	"Return to the throne room to conduct your fifth interview with SCP-6462-C-1.",
	"Return to the throne room to confront SCP-6462-C-1."
]
# Used to prevent repeats of the dialog on one day. 
signal day_dialogue_over(new_start : String)
var main_dialogue_over : bool = false
var day_counter : int = 0


# CAMERA SHAKE 
var initial_strength : float = 30.0
var shake_fade : float = 5.0
var rng = RandomNumberGenerator.new()
var shake_strength : float = 0.0

# DIALOGUE

# SAVE DATA
const SAVE_FILE_PATH : String = ""
var current_main_dialogue : String = "interview_1"
var explored_areas : Array[String] = []

var objective : String = "Enter the throne room, and begin your first interview with SCP-6462-C-1."
var sub_objectives : String = "Explore the palace, and discover new rooms."

const DEFAULT_SAVE_DATA : Dictionary = {
	"is_new_game": true,
	"current_main_dialogue" : "interview_1",
	"current_scene_path" : "res://Levels/PalaceRooms/central_hall.tscn",
	"palace_rooms" : [],
	"explored_rooms" : [],
	"objective" : "Enter the throne room and conduct your first interview with SCP-6462-C-1.",
	"sub_objective" : "Continue to explore the palace.",
}

func _initial_setup():
	var root = get_tree().root
	root.add_child.call_deferred(main_menu)
	
func load_data():
	pass

func save():
	var save_dict = {
		"current_main_dialogue" : current_main_dialogue,
		"current_scene" : SceneSwitcher.current_scene,
		"palace_rooms" : SceneSwitcher.palace_rooms,
		"explored_areas" : explored_areas,
		"objective": objective,
		"sub_objectives": sub_objectives
	}

func show_opening():
	main_menu.queue_free()
	var root = get_tree().root
	root.add_child(opening_scene)

func begin_game():
	print("Beginning game!")
	opening_scene.free()
	SceneSwitcher._change_player_state("PlayerWalk")
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	goto_next_day()

func end_game():
	reset_data()
	SceneSwitcher.switch_scene("res://Levels/PalaceRooms/central_hall.tscn")
	_initial_setup()

func reset_data():
	day_counter = 0
	objective = ALL_OBJECTIVES[0]
	
# Next interview 
func goto_next_day():
	GameUi.make_hud_invisible()
	GameUi.set_objective(objective)
	GameUi.set_sub_objective(sub_objectives)
	current_main_dialogue = ALL_DIALOGUE[day_counter]
	main_dialogue_over = false
	day_counter += 1
	SceneSwitcher.switch_scene("res://Levels/PalaceRooms/central_hall.tscn")
	GameUi.day_label.text = "[center]DAY %s[/center]" % str(day_counter)
	GameUi.new_day_transition_effect()

# SCREEN SHAKE 

func screen_shake():
	shake_strength = initial_strength

func _process(delta):
	if shake_strength > 0:
		shake_strength = lerpf(shake_strength, 0 , shake_fade * delta)
		var randomOffset = Vector2(rng.randf_range(-shake_strength, shake_strength), rng.randf_range(-shake_strength, shake_strength))
		SceneSwitcher.player_node.camera.offset = randomOffset
