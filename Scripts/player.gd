extends CharacterBody2D

@onready var animation: AnimatedSprite2D = $Animation

# Constants for movement physics
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _physics_process(delta: float) -> void:
	# Add gravity if the character is in the air
	if not is_on_floor():
		velocity += get_gravity() * delta
		if velocity.y < 0:
			animation.play("jump")
		else:
			animation.play("fall")
	
	# Handle jump input
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction: -1 (left), 1 (right), or 0 (none)
	var direction := Input.get_axis("left", "right")
	# flip sprite based on direction
	if direction < 0:
		animation.flip_h = false
	elif direction > 0:
		animation.flip_h = true
	
	if is_on_floor() and velocity.x != 0:
		animation.play("walk")
	elif velocity.x == 0 and velocity.y == 0:
		animation.play("idle")
	
	# Apply movement or deceleration
	if direction:
		velocity.x = direction * SPEED
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Execute the movement and handle collisions
	move_and_slide()
