extends CanvasLayer

@onready var water_value = $"MarginContainer/VBoxContainer/WaterPanel/HBoxContainer/Water Value"
@onready var seed_value = $MarginContainer/VBoxContainer/SeedPanel/HBoxContainer/SeedValue

# NOTE: If your node in the scene tree is still named "TimeContai", change this path to $TimeContai/TimeLabel
@onready var time_label = $TimerContainer/TimeLabel

var total_seconds: int = 0

func _ready():
	# Connects the timer node so it triggers the timeout function every second
	visible = true
	$ClockTimer.timeout.connect(_on_clock_timer_timeout)
	Inventory.inventory_changed.connect(_on_inventory_changed)
	_on_inventory_changed()

func _on_inventory_changed():
	seed_value.text = str(Inventory.seeds)
	water_value.text = str(Inventory.water)

# This function is called every time the ClockTimer ticks
func _on_clock_timer_timeout():
	total_seconds += 1
	
	# Calculate minutes and seconds
	var minutes = total_seconds / 60
	var seconds = total_seconds % 60
	
	# Format the text to always show two digits (e.g., 05:09)
	time_label.text = "%02d:%02d" % [minutes, seconds]
