# HUG.gd
extends CanvasLayer

@onready var label_health = $MarginContainer/VBoxContainer/LabelHealth
@onready var label_seeds = $MarginContainer/VBoxContainer/LabelSeeds
@onready var label_water = $MarginContainer/VBoxContainer/LabelWater
@onready var label_food = $MarginContainer/VBoxContainer/LabelFood

func _ready() -> void:
	Inventory.inventory_changed.connect(_on_inventory_changed)
	_on_inventory_changed()
	
func _on_inventory_changed() -> void:
	label_health.text = "❤️  " + str(Inventory.health)
	label_seeds.text  = "🌱  " + str(Inventory.seeds)
	label_water.text  = "💧  " + str(Inventory.water)
	label_food.text   = "🍞  " + str(Inventory.food)
