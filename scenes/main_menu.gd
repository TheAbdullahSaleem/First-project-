## main_menu.gd
## Production-ready entry point for "The Last Harvest".
## Opens whenever the game is launched; "New Game" resets all state and loads the world.
extends Control

const WORLD_SCENE := "res://scenes/world/World.tscn"

func _ready() -> void:
	# Ensure the cursor is visible on the menu (may have been hidden in-game)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_new_game_pressed() -> void:
	_reset_game_state()
	get_tree().change_scene_to_file(WORLD_SCENE)

func _on_quit_pressed() -> void:
	get_tree().quit()

# ---------------------------------------------------------------------------
# Reset all autoload state so every new game starts from a clean slate.
# ---------------------------------------------------------------------------
func _reset_game_state() -> void:
	# Reset day/night cycle
	DayNightCycle.reset()
	# Reset inventory
	Inventory.reset()
