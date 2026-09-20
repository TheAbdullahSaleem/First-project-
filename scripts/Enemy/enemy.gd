extends CharacterBody2D


const SPEED = 100.0
var target_crop: Node2D = null

func _ready() -> void:
	add_to_group("enemy")

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if not is_instance_valid(target_crop):
		target_crop = find_nearest_crop()
	
	if target_crop:
		if global_position.distance_to(target_crop.global_position) < 10.0:
			target_crop.queue_free()
			target_crop = null
		else:
			var direction_x = sign(target_crop.global_position.x - global_position.x)
			velocity.x = direction_x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
	

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
