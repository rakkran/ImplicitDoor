extends Control

@onready var interaction_prompt : InteractionPrompt = $InteractionInfo/InteractionPrompt
@onready var interaction_text : InteractionText = $InteractionInfo/InteractionText
@onready var book_layer : CanvasLayer = $BookInteraction
@onready var book_interaction = $BookInteraction/Control/MarginContainer/BookText

@onready var scene_transition = $SceneTransition/AnimationPlayer
@onready var day_transition = $SceneTransition/DayContainer/AnimationPlayer
@onready var day_label = $SceneTransition/DayContainer/DayCounter

@onready var hud = $HUD
@onready var objective = $HUD/Objective
@onready var sub_objectives = $HUD/SubObjectives

signal change_player_state(new_state)
signal exit_interaction_text

# Bools
var interact_text_state = false
var interact_book_state = false
var interact_speech_state = false

func _ready():
	change_player_state.connect(SceneSwitcher._change_player_state)
	exit_interaction_text.connect(_exit_interact_text)

func _physics_process(delta):
	if Input.is_action_just_pressed("interact"):
		if interact_text_state:
			interaction_text.skip_text() 
		elif interact_book_state:
			book_interaction.next_page()

# INTERACTION PROMPT FUNCTIONS
func set_prompt(prompt : String):
	interaction_prompt.set_new_prompt(prompt)

func remove_prompt():
	interaction_prompt.reset_prompt()


# INTERACTION TEXT FUNCTIONS
func set_interact_text(display_text : Array[String]):
	interact_text_state = true
	# Hide prompt 
	interaction_prompt.visible_ratio = 0.0
	interaction_text.set_display_text(display_text)
	change_player_state.emit("PlayerInteract")

func _exit_interact_text():
	interact_text_state = false
	interaction_prompt.visible_ratio = 1.0
	interaction_text.exit_interact()
	change_player_state.emit("PlayerWalk")
	
	
# BOOK TEXT FUNCTIONS 
func set_book_text(display_text : Array[String]):
	if not interact_book_state:
		interact_book_state = true
		book_interaction.set_book_text(display_text)
		book_layer.visible = true
		change_player_state.emit("PlayerInteract")

func exit_book_text():
	interact_book_state = false
	book_interaction.exit_book()
	book_layer.visible = false
	change_player_state.emit("PlayerWalk")

# SCENE TRANSITION EFFECTS 
func scene_transition_effect(res_path):
	change_player_state.emit("PlayerInteract")
	scene_transition.play("dissolve")
	await(scene_transition.animation_finished)
	SceneSwitcher._deferred_switch_scene(res_path)
	scene_transition.play_backwards("dissolve")
	await(scene_transition.animation_finished)
	change_player_state.emit("PlayerWalk")

func new_day_transition_effect():
	change_player_state.emit("PlayerInteract")
	day_transition.play("transition")
	await(day_transition.animation_finished)
	change_player_state.emit("PlayerWalk")
	make_hud_visible()

func set_objective(obj_text):
	objective.text = "[b]Objective:[/b]\n" + obj_text

func set_sub_objective(obj_text):
	sub_objectives.text = "[b]Sub-Objective:[/b]\n" + obj_text


func make_hud_visible():
	hud.visible = true

func make_hud_invisible():
	hud.visible = false

