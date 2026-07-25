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
@onready var player_ray: RayCast2D = $player_ray

func _physics_process(delta: float) -> void:
	match state:
		STATE.PATROL:
			handle_patrol(delta)
		STATE.AGRO:
			handle_agro(delta)

func handle_patrol(delta: float) -> void:
	if player_ray.is_colliding():
		var collider = player_ray.get_collider()
		if collider.name == "Player":
			state = STATE.AGRO
		
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

func handle_agro(delta) -> void:
	if in_leap and is_on_floor():
		in_leap = false
		stop_agro()
	var player_posi = player_ray.get_collider()
	if player_posi:
		player_posi = player_posi.global_position
		player_posi = global_position - player_posi
		if is_on_floor():
			handle_Ajump(player_posi)
	handle_gravity(delta)
	handle_agro_animation()
	move_and_slide()

func handle_Ajump(pos: = Vector2()) -> void:
	in_leap = true
	velocity.y = agro_velY
	var air_time = (2.0 * abs(agro_velY)) / gravity
	agro_velX = pos.x/air_time

func handle_gravity(delta):
	velocity.y += gravity * delta

func switch_direction() -> void:
	wall_ray_cast.scale.x = ground_ray_cast.scale.x*-1
	ground_ray_cast.scale.x = ground_ray_cast.scale.x* -1
	direction = direction * -1
	player_ray.scale.x = player_ray.scale.x* -1
	sprite.scale.x = sprite.scale.x* -1


func handle_agro_animation() -> void:
	if is_on_floor():
		sprite.play("tracking")
	else:
		if velocity.y < 0:
			sprite.play("tracking-jump")
		else:
			sprite.play("tracking_fall")

func stop_agro() -> void:
	state=STATE.PATROL
