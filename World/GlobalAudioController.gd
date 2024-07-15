extends Node

@onready var SFX_Player = $SFX
@onready var Music_Player = $Music

var DOOR_SFX = ResourceLoader.load("res://Assets/Audio/SFX/door_open.wav")

func play_door_sfx():
	SFX_Player.stream = DOOR_SFX
	SFX_Player.play()
