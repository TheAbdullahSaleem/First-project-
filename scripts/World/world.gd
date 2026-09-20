extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DayNightCycle.soil_tiles = get_tree().get_nodes_in_group("soil_tiles")
	$Day.visible = true
	$Night.visible = false
	DayNightCycle.night_started.connect(_on_night_started)
	DayNightCycle.day_started.connect(_on_day_started)

func _on_night_started():
	$Night.visible = true
	$Day.visible = false

func _on_day_started(day_number: int):
	$Day.visible = true
	$Night.visible = false
