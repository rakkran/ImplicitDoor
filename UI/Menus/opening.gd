extends Control

@onready var timer = $Timer
@onready var scroll_container = $MarginContainer/ScrollContainer

const SCROLL_SPEED : float = 5.0

# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	if Input.is_action_just_pressed("interact"):
		Global.begin_game()
	#if Input.is_action_pressed("down_scroll") or Input.is_action_pressed("ui_down"):
		#scrollbar.scroll_vertical -= (SCROLL_SPEED * delta)
	#elif Input.is_action_pressed("up_scroll") or Input.is_action_pressed("ui_up"):
		#scrollbar.scroll_vertical += (SCROLL_SPEED * delta)
	


func _on_scroll_container_scroll_ended():
	print(scroll_container.scroll_vertical)
