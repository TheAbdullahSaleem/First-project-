extends CanvasLayer

@onready var health_bar = $MarginContainer/VBoxContainer/HealthPanel/HBoxContainer/ProgressBar
@onready var water_value = $"MarginContainer/VBoxContainer/WaterPanel/HBoxContainer/Water Value"
@onready var seed_value = $MarginContainer/VBoxContainer/SeedPanel/HBoxContainer/SeedValue

# NOTE: If your node in the scene tree is still named "TimeContai", change this path to $TimeContai/TimeLabel
@onready var time_label = $TimerContainer/TimeLabel

var total_seconds: int = 0

func _ready():
	# Connects the timer node so it triggers the timeout function every second
	$ClockTimer.timeout.connect(_on_clock_timer_timeout)

func update_health(new_health: int):
	health_bar.value = new_health

func update_water(new_amount: int):
	water_value.text = str(new_amount)

func update_seeds(new_amount: int):
	seed_value.text = str(new_amount)

# This function is called every time the ClockTimer ticks
func _on_clock_timer_timeout():
	total_seconds += 1
	
	# Calculate minutes and seconds
	var minutes = total_seconds / 60
	var seconds = total_seconds % 60
	
	# Format the text to always show two digits (e.g., 05:09)
	time_label.text = "%02d:%02d" % [minutes, seconds]
