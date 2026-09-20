extends CharacterBody2D


const SPEED = 100.0
var target_crop: Node2D = null


func _physics_process(delta: float) -> void:
	if not is_instance_valid(target_crop):
		target_crop = find_nearest_crop()
	
	if target_crop:
		var direction = global_position.direction_to(target_crop.global_position)
		velocity = direction * SPEED
		move_and_slide()
	else:
		velocity = Vector2.ZERO
	

func find_nearest_crop():
	var crops = get_tree().get_nodes_in_group("crops")
	
	if crops.is_empty():
		return
	
	var nearest = null
	var shortest_dist = INF
	
	for crop in crops:
		var dist = global_position.distance_to(crop.global_position)
		if dist < shortest_dist:
			shortest_dist = dist
			nearest = crop
	
	return nearest
