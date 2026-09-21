# Inventory.gd
extends Node

# Resources the player holds
var seeds: int = 5
var water: int = 5
var food: int = 0
var health: int = 100
var max_water: int = 15

signal inventory_changed  # UI listens to this

func add_seeds(amount: int) -> void:
	seeds += amount
	inventory_changed.emit()

func use_seed() -> bool:
	if seeds > 0:
		seeds -= 1
		inventory_changed.emit()
		return true
	return false  # not enough seeds

func use_water() -> bool:
	if water > 0:
		water -= 1
		inventory_changed.emit()
		return true
	return false

func add_food(amount: int) -> void:
	food += amount
	inventory_changed.emit()

func add_water(amount: int) -> void:
	if (water + amount) <= max_water:
		water += amount
		inventory_changed.emit()
	else:
		print("Max water storage is 15")
