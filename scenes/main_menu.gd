extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_new_game_pressed() -> void:
	# Note: Update "res://world.tscn" if your world scene is in a different folder 
	# (e.g., "res://scenes/world.tscn")
	get_tree().change_scene_to_file("res://scenes/world/World.tscn")

# Be sure to connect your Quit button's pressed() signal to this function!
func _on_quit_pressed() -> void:
	get_tree().quit()
