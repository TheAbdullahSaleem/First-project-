# Crop.gd
class_name Crop
extends Node2D

@export var crop_data: CropData   # assign in Inspector or via code

@onready var sprite = $Sprite2D

var current_stage: int = 0        # 0 = just planted
var is_watered: bool = false
var days_since_last_growth: int = 0

signal crop_harvested(amount: int)

func _ready() -> void:
	add_to_group("crops")
	update_sprite()

# Called by the Day/Night system at the start of each new day
func on_new_day() -> void:
	days_since_last_growth += 1
	
	if is_watered and days_since_last_growth >= crop_data.days_to_grow:
		grow()
		days_since_last_growth = 0
		is_watered = false   # needs watering again next day
	

func grow() -> void:
	if current_stage < crop_data.crop_stages - 1:
		current_stage += 1
		update_sprite()

func water_crop() -> void:
	if is_watered:
		print("Already watered")
		return  # already watered today
	if not Inventory.use_water():
		print("No water left!")
		return
	is_watered = true
	print("Watering done")
	# Optional: add a visual tint or water droplet effect here

func harvest() -> void:
	if current_stage < crop_data.crop_stages - 1:
		print("Not ready yet!")
		return
	Inventory.add_food(crop_data.food_yield)
	Inventory.add_seeds(randi_range(2, 3))
	SignalBus.crop_harvested.emit(crop_data.food_yield)
	
	queue_free()   # remove crop from world after harvest

func update_sprite() -> void:
	if crop_data and crop_data.stage_textures.size() > current_stage:
		sprite.texture = crop_data.stage_textures[current_stage]

func is_fully_grown() -> bool:
	return current_stage >= crop_data.crop_stages - 1

# Called when player presses E near this crop
func interact() -> void:
	if is_watered || is_fully_grown():
		harvest()
	else:
		water_crop()
