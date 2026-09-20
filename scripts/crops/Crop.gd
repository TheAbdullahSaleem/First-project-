# Crop.gd
class_name Crop
extends Node2D

@export var crop_data: CropData   # assign in Inspector or via code

@onready var sprite = $Sprite2D
@onready var label = $Label

var current_stage: int = 0        # 0 = just planted
var is_watered: bool = false
var is_mutated: bool = false
var days_since_last_growth: int = 0

signal crop_harvested(food_amount: int)
signal crop_mutated

func _ready() -> void:
	update_sprite()
	label.visible = false

# Called by the Day/Night system at the start of each new day
func on_new_day() -> void:
	days_since_last_growth += 1
	
	if is_watered and days_since_last_growth >= crop_data.days_to_grow:
		grow()
		days_since_last_growth = 0
		is_watered = false   # needs watering again next day
	
	# Random mutation chance on day 2+ (if allowed)
	if current_stage >= 2 and crop_data.can_mutate and not is_mutated:
		if randf() < 0.3:    # 30% chance
			mutate()

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
	# Optional: add a visual tint or water droplet effect here

func harvest() -> void:
	if current_stage < crop_data.crop_stages - 1:
		print("Not ready yet!")
		return
	Inventory.add_food(crop_data.food_yield)
	crop_harvested.emit(crop_data.food_yield)
	queue_free()   # remove crop from world after harvest

func mutate() -> void:
	is_mutated = true
	# Change sprite to cursed/black-root version
	sprite.modulate = Color(0.1, 0.0, 0.1)   # dark purple tint for now
	crop_mutated.emit()

func update_sprite() -> void:
	if crop_data and crop_data.stage_textures.size() > current_stage:
		sprite.texture = crop_data.stage_textures[current_stage]

func is_fully_grown() -> bool:
	return current_stage >= crop_data.crop_stages - 1

# Called when player presses E near this crop
func interact() -> void:
	if is_mutated:
		show_mutation_choice()
		return
	if is_fully_grown():
		harvest()
	else:
		water_crop()

func show_mutation_choice() -> void:
	# You'll connect this to a UI popup later
	# For now just print — replace with actual dialog
	print("A black root grows here. [A] Harvest  [B] Destroy  [C] Leave")
	crop_mutated.emit()   # UI listens to show choice dialog

func show_prompt():
	label.text = "[E]"
	label.visible = true
	
func hide_prompt():
	label.visible = false
