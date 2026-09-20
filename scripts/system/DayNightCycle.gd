# DayNightCycle.gd
extends Node

var current_day: int = 1
var day_length_seconds: float = 210.0   # 3.5 minutes per day
var time_elapsed: float = 0.0
var is_night: bool = false

signal day_started(day_number: int)
signal night_started
signal day_ended

# Reference to all soil tiles in the world
# You'll populate this from the World scene
var soil_tiles: Array = []

func _process(delta: float) -> void:
	time_elapsed += delta
	
	# Halfway through = sunset
	if not is_night and time_elapsed >= day_length_seconds * 0.01:
		start_night()
	
	# Full cycle = new day
	if time_elapsed >= day_length_seconds:
		time_elapsed = 0.0
		day_ended.emit()
		start_new_day()

func start_night() -> void:
	is_night = true
	night_started.emit()
	print("Night has begun. Something is coming...")

func start_new_day() -> void:
	is_night = false
	current_day += 1
	
	# Tell all crops to grow
	for tile in soil_tiles:
		tile.on_new_day()
	
	day_started.emit(current_day)
	print("Day %d begins." % current_day)

func skip_night():
	if is_night == true:
		time_elapsed = 0.0
		start_new_day()
	else:
		print("It's daytime")
