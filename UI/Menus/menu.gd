extends Control

func _ready():
	SceneSwitcher._change_player_state("PlayerInteract")
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	GameUi.make_hud_invisible()

#func _physics_process(delta):
	#if Input.is_action_pressed("interact"):
		#Global.show_opening()
	#elif Input.is_action_pressed("ui_cancel"):
		#Global.save()
		#get_tree().quit()


func _on_begin_pressed():
	Global.show_opening()
	
func _on_quit_pressed():
	Global.save()
	get_tree().quit() #
