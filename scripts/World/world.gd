extends Node2D

<<<<<<< HEAD
=======
@export var enemy_scene: PackedScene
var spawn_timer: Timer

>>>>>>> 80aa9e9d6874a564c3fee99c12db3669b613bf2e
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DayNightCycle.soil_tiles = get_tree().get_nodes_in_group("soil_tiles")
	$Day.visible = true
	$Night.visible = false
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
	spawn_timer.start(randf_range(5.0, 10.0))

func _on_night_started():
	$Night.visible = true
	$Day.visible = false
	start_random_timer()

func spawn_enemy():
	var enemy = enemy_scene.instantiate()
	var camera = $CharacterBody2D/Camera2D
	
	var viewport_size = get_viewport_rect().size
	var spawn_radius = max(viewport_size.x, viewport_size.y) * 0.7
	
	var random_angle = randf() * TAU
	
	var spawn_offset = Vector2.RIGHT.rotated(random_angle) * spawn_radius
	enemy.global_position = camera.global_position + spawn_offset
	
	add_child(enemy)
	

func _on_day_started(day_number: int):
	$Day.visible = true
	$Night.visible = false
	spawn_timer.stop()
