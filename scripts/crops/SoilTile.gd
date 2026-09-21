# SoilTile.gd
extends Node2D

@export var default_crop_data: CropData   # what seed to plant here

@onready var sprite = $Sprite2D
@export var tilled_texture: Texture2D
@export var bare_texture: Texture2D

var is_tilled: bool = false
var crop_instance: Crop = null    # currently planted crop

const CROP_SCENE = preload("res://scenes/crops/Crop.tscn")

func _ready():
	sprite.texture = bare_texture

# Called when player presses E on this tile
func interact() -> void:
	if crop_instance != null:
		crop_instance.interact()   # forward to the crop
		return
	
	if not is_tilled:
		till_soil()
	else:
		plant_seed()

func till_soil() -> void:
	is_tilled = true
	sprite.texture = tilled_texture
	Log.player_message("Soil tilled")

func plant_seed() -> void:
	if not Inventory.use_seed():
		Log.player_message("No seeds!")
		return
	
	crop_instance = CROP_SCENE.instantiate()
	crop_instance.crop_data = default_crop_data
	
	# moves the crop on top
	crop_instance.position = Vector2(0, -16)


	add_child(crop_instance)
	
	Log.player_message("seed planted")
	
	# Listen for harvest so we know the crop is gone
	crop_instance.crop_harvested.connect(_on_crop_harvested)

func _on_crop_harvested(_amount: int) -> void:
	crop_instance = null   # slot is empty again

# Called by DayNightCycle at start of each new day
func on_new_day() -> void:
	if crop_instance != null:
		crop_instance.on_new_day()
