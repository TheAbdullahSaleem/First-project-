extends CharacterBody2D

var interactable_in_range = null

const SPEED = 100.0
const JUMP_VELOCITY = -500.0
const GRAVITY = 1200.0

@onready var anim = $AnimatedSprite2D


func _ready() -> void:
	if not $Area2D.area_entered.is_connected(_on_area_2d_area_entered):
		$Area2D.area_entered.connect(_on_area_2d_area_entered)

	if not $Area2D.area_exited.is_connected(_on_area_2d_area_exited):
		$Area2D.area_exited.connect(_on_area_2d_area_exited)


func _physics_process(delta: float) -> void:
	# Gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	else:
		velocity.y = 0
	
	# Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Horizontal movement
	var direction := Input.get_axis("left", "right")

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

	_update_animation(direction)


func _update_animation(direction: float) -> void:
	if direction > 0:
		anim.play("right")
	elif direction < 0:
		anim.play("left")
	else:
		anim.play("stand")


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area is Interactable:
		if interactable_in_range != null:
			interactable_in_range.hide_prompt()

		interactable_in_range = area as Interactable
		interactable_in_range.show_prompt()


func _on_area_2d_area_exited(area: Area2D) -> void:
	if area == interactable_in_range:
		interactable_in_range.hide_prompt()
		interactable_in_range = null


# Attack function
func attack():
	pass


# Check for inputs
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Interact") and interactable_in_range != null:
		interactable_in_range.interact()

	if event.is_action_pressed("Attack"):
		attack()
