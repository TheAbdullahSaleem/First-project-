extends Node2D

@export var enemy_scene: PackedScene
var spawn_timer: Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DayNightCycle.soil_tiles = get_tree().get_nodes_in_group("soil_tiles")
	$Day.visible = true
	$Day2.visible = true
	$Night.visible = false
	$Night2.visible = false
	DayNightCycle.night_started.connect(_on_night_started)
	DayNightCycle.day_started.connect(_on_day_started)
	
	# create spawn timer
	spawn_timer = Timer.new()
	add_child(spawn_timer)
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)

func _on_spawn_timer_timeout():
	if enemy_scene:
		spawn_enemy()
	start_random_timer()

func start_random_timer():
	spawn_timer.start(randf_range(3.0, 5.0))

func _on_night_started():
	$Night.visible = true
	$Night2.visible = true
	$Day.visible = false
	$Day2.visible = false
	start_random_timer()

func spawn_enemy():
	var enemy = enemy_scene.instantiate()
	var camera = $CharacterBody2D/Camera2D
	var viewport_size = get_viewport_rect().size
	
	var random_direction = 1 if randf() > 0.5 else -1
	var ideal_x = camera.global_position.x + (viewport_size.x * 0.7 * random_direction)
	
	var spawn_x = clampf(ideal_x, -192.0, 1000.0)
	
	var random_height = camera.global_position.y - randf_range(0, viewport_size.y * 0.5)
	
	var spawn_y = min(random_height, -50.0)
	
	enemy.global_position = Vector2(spawn_x, spawn_y)
	
	add_child(enemy)
	Log.player_message("enemy spawned")

func _on_day_started(day_number: int):
	$Day.visible = true
	$Day2.visible = true
	$Night.visible = false
	$Night2.visible = false
	spawn_timer.stop()
	
	var enemies = get_tree().get_nodes_in_group("enemy")
	for enemy in enemies:
		enemy.queue_free()
	
