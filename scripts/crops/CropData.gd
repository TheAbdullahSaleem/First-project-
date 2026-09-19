# CropData.gd
class_name CropData
extends Resource

@export var crop_name: String = "Wheat"
@export var crop_stages: int = 4 # number of stages to grow
@export var days_to_grow: int = 2 # days between stages
@export var food_yield: int = 2 # food gained on harvest
@export var can_mutate: bool = true # cursed crop

# Sprite for each growth stage
@export var stage_textures: Array[Texture2D] = []
