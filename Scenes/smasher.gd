extends CharacterBody2D

@export var patrol_velY := -50
@export var patrol_velX := 100
@export var agro_velY := -100
@export var agro_velX := 100
@export var is_chasing := false
@export var state:= STATE.PATROL
@export var gravity := 100
@export var in_leap:= false
var direction := -1 # -1 right, 1 left
enum STATE  {PATROL, AGRO}

@onready var patrol_timer: Timer = $patrolTimer
@onready var ground_ray_cast: RayCast2D = $groundRayCast
@onready var wall_ray_cast: RayCast2D = $wallRayCast
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
		handle_patrol(delta)

func handle_patrol(delta: float) -> void:
		
	if is_on_floor() and not ground_ray_cast.is_colliding() or is_on_floor() and wall_ray_cast.is_colliding():
		switch_direction()
	if is_on_floor() and is_chasing == false and not patrol_timer.time_left > 0:
		handle_Pjump()
	if not is_on_floor():
		velocity.x = patrol_velX * direction
	else:
		velocity.x = 0
	handle_patrol_animation()
	handle_gravity(delta)
	move_and_slide()

func handle_Pjump() -> void:
	velocity.y = patrol_velY
	patrol_timer.start()

func handle_patrol_animation() -> void:
	if is_on_floor():
		sprite.play("normal")
	else:
		if velocity.y < 0:
			sprite.play("jump")
		else:
			sprite.play("fall")


func handle_gravity(delta):
	velocity.y += gravity * delta

func switch_direction() -> void:
	wall_ray_cast.scale.x = ground_ray_cast.scale.x*-1
	ground_ray_cast.scale.x = ground_ray_cast.scale.x* -1
	direction = direction * -1
	sprite.scale.x = sprite.scale.x* -1
