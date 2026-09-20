# MainMenu.gd
extends Control

const GAME_SCENE = "res://scenes/world/World.tscn"

@onready var btn_new_game = $Background/VBoxContainer/NewGame
@onready var btn_quit     = $Background/VBoxContainer/Quit

func _ready() -> void:
	btn_new_game.pressed.connect(_on_new_game)
	btn_quit.pressed.connect(_on_quit)

func _on_new_game() -> void:
	get_tree().change_scene_to_file(GAME_SCENE)

func _on_quit() -> void:
	get_tree().quit()
