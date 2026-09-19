# inventory.gd
extends Node

# Resources the player holds
var seeds: int = 3
var water: int = 5
var food: int = 0
var health: int = 100

signal inventory_changed

func add_seeds(amount: int) -> void:
		seed += amount
		emit_signal("inventory_changed")

func use_seed() -> bool:
		if seeds > 0:
			seed -= 1
		emit_signal("inventory_changed")
		return true
		return false # Not enough seeds

func use_water() -> bool:
		if water > 0:
			water -= 1
		emit_signal("inventory_changed")
		return true
		return false # Not enough water
		
func add_food(amount: int) -> void:
		food += amount
		emit_signal("inventory_changed")
