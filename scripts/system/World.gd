# World.gd
# Attach this script to the root "World" node in World.tscn
extends Node2D

# ── Camera limits — set these to your map size in pixels ──
# tiles wide × tile size px = total width
# e.g. 40 tiles × 16px = 640
const CAM_LIMIT_LEFT   = 0
const CAM_LIMIT_TOP    = 0
const CAM_LIMIT_RIGHT  = 640   # ← change to your map width
const CAM_LIMIT_BOTTOM = 360   # ← change to your map height

func _ready() -> void:
	# Find every SoilTile node that is in the "SoilTile" group
	# and register it with DayNightCycle so crops grow each day
	for tile in get_tree().get_nodes_in_group("SoilTile"):
		DayNightCycle.soil_tiles.append(tile)

	Log.player_message("World ready. Registered %d soil tiles." % DayNightCycle.soil_tiles.size())

	_setup_camera_limits()

func _setup_camera_limits() -> void:
	# Find the player's Camera2D anywhere in the scene tree
	var cam = get_tree().get_first_node_in_group("PlayerCamera")
	if cam == null:
		# fallback: search by type
		cam = _find_camera(self)
	if cam:
		cam.limit_left   = CAM_LIMIT_LEFT
		cam.limit_top    = CAM_LIMIT_TOP
		cam.limit_right  = CAM_LIMIT_RIGHT
		cam.limit_bottom = CAM_LIMIT_BOTTOM
		Log.player_message("Camera limits set: %d %d %d %d" % [CAM_LIMIT_LEFT, CAM_LIMIT_TOP, CAM_LIMIT_RIGHT, CAM_LIMIT_BOTTOM])
	else:
		Log.player_message("No Camera2D found in scene.")

# Recursively search for a Camera2D node
func _find_camera(node: Node) -> Camera2D:
	if node is Camera2D:
		return node
	for child in node.get_children():
		var result = _find_camera(child)
		if result:
			return result
	return null
