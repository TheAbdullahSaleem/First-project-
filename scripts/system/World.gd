# World.gd
# Attach this script to the root "World" node in World.tscn
extends Node2D

func _ready() -> void:
	# Find every SoilTile node that is in the "SoilTile" group
	# and register it with DayNightCycle so crops grow each day
	for tile in get_tree().get_nodes_in_group("SoilTile"):
		DayNightCycle.soil_tiles.append(tile)
	
	print("World ready. Registered %d soil tiles." % DayNightCycle.soil_tiles.size())
