extends CharacterBody2D

@export var inCScene:= false

@onready var base_position :Vector2 = position
@onready var animation: AnimatedSprite2D = $Animation
@onready var time_label: Label = $CanvasLayer/Time_label
@onready var game_over_screen: CanvasLayer = $game_over_screen
# Constants for movement physics
const SPEED = 100.0
const JUMP_VELOCITY = -400.0
const ACCELERATION := 50
const DECELERATION := 100
var facing := 1
var gears: Array = []
var hasGear

func _ready() -> void:
	get_tree().paused = false
	Dialogic.signal_event.connect(_dialogic_signal)

func _physics_process(delta: float) -> void:
	if inCScene:
		velocity += get_gravity() * delta
	else:
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
		if Input.is_action_just_released("jump") and velocity.y < JUMP_VELOCITY/2:
			velocity.y = JUMP_VELOCITY/2
		if Input.is_action_just_pressed("dialogueTest"):
			Dialogic.start("timeline")

		# Get the input direction: -1 (left), 1 (right), or 0 (none)
		var direction := Input.get_axis("left", "right")
		# flip sprite based on direction
		if direction < 0:
			facing = 1
			animation.flip_h = false
		elif direction > 0:
			facing = -1
			animation.flip_h = true
		
		if is_on_floor() and velocity.x != 0:
			animation.play("walk")
		elif velocity.x == 0 and velocity.y == 0:
			animation.play("idle")
		
		# Apply movement or deceleration
		if direction:
			velocity.x = move_toward(velocity.x, direction * SPEED, ACCELERATION)
		else:
			velocity.x = move_toward(velocity.x, 0, DECELERATION)
		
		# set the time on the label
		time_label.text = "Time: " + str(Countdown.countdown_time)
		
		# Execute the movement and handle collisions
	move_and_slide()

func die2():
	print("you died")
	velocity.y = 0
	position = base_position
	for gear in gears:
		if is_instance_valid(gear):
			gear.reset()
	gears.clear()
	hasGear = false
	LevelReset.reset_gears = true

func die():
	print("you died")
	velocity.y = 0
	await Deathscreen.fade_out()
	position = base_position
	for gear in gears:
		if is_instance_valid(gear):
			gear.reset()
	gears.clear()
	hasGear = false
	await Deathscreen.fade_in()
	LevelReset.reset_gears = true


func _on_timer_timeout() -> void:
	if Countdown.countdown_time > 0:
		Countdown.countdown_time -= 1
	else:
		game_over_screen.visible = true
		get_tree().paused = true

func _dialogic_signal(argument: String):
	if argument == "start":
		inCScene = true
		print("start")
	if argument == "end":
		inCScene = false
		print("end")
