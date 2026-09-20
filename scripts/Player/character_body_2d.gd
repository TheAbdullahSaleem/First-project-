extends CharacterBody2D
var i_eat = "True"
var interactable_in_range = null

const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	velocity += get_gravity() * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	

func _on_interaction_zone_area_entered(area: Area2D) -> void:
	# check if area is interactable
	if area is Interactable:
		# if there was alredy an interabtable area in range hide its prompt
		if interactable_in_range != null:
			interactable_in_range.hide_prompt()
		
		 # show prompt of new interactable area
		interactable_in_range = area as Interactable
		interactable_in_range.show_prompt()

func _on_interaction_zone_area_exited(area: Area2D) -> void:
	# if area that exited was the latest one in range, then hide its prompt
	if area == interactable_in_range:
		interactable_in_range.hide_prompt()
		interactable_in_range = null

# Attack function
func attack():
	pass

# Check for inputs
func _input(event: InputEvent) -> void:
	# If E is pressed, trigger interact function of interactable area
	if event.is_action_pressed("Interact"):
		interactable_in_range.interact()
	# If attack key is pressed, then call the attack function
	if event.is_action_pressed("Attack"):
		attack();
