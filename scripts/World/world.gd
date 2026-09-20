extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DayNightCycle.soil_tiles = get_tree().get_nodes_in_group("soil_tiles")
