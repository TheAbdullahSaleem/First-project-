extends CharacterBody2D


const SPEED = 50.0
var target_crop: Node2D = null
var destroy_timer: Timer
@onready var anim = $Enemy
var allowed = true
func _ready() -> void:
	add_to_group("enemy")
	destroy_timer = Timer.new()
	add_child(destroy_timer)
	destroy_timer.timeout.connect(_on_destruction)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if not is_instance_valid(target_crop):
		target_crop = find_nearest_crop()
	
	
	
	if target_crop:
		var direction_x = sign(target_crop.global_position.x - global_position.x)
		if global_position.distance_to(target_crop.global_position) < 10.0 and allowed:
			allowed = false
			destroy_timer.start(2.0)
			Log.player_message("Timer started")
		else:
			
			velocity.x = direction_x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
	
	_update_animation(velocity.x)
	

func _update_animation(direction: float) -> void:
	if direction > 0:
		anim.play("right")
	elif direction < 0:
		anim.play("left")
	else:
		anim.stop()

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


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		queue_free()

func _on_destruction():
	if target_crop:
		target_crop.queue_free()
		target_crop = null
	allowed = true
