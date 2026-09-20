extends CanvasLayer

@onready var health_bar = $MarginContainer/VBoxContainer/HealthPanel/HBoxContainer/ProgressBar
@onready var water_value = $MarginContainer/VBoxContainer/WaterPanel/HBoxContainer/WaterValuenew
@onready var seed_value = $MarginContainer/VBoxContainer/SeedPanel/HBoxContainer/SeedValuenew

func update_health(new_health: int):
	health_bar.value = new_health

func update_water(new_amount: int):
	water_value.text = str(new_amount)

func update_seeds(new_amount: int):
	seed_value.text = str(new_amount)
