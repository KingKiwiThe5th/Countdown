extends CharacterBody2D

@export var patrol_speed := 100.0
@export var chase_speed := 150.0

@onready var player_ray: RayCast2D = $RayCast_toPlayer
@onready var wall_ray: RayCast2D = $WallRayCast
@onready var floor_ray: RayCast2D = $RayCast_floor
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var direction := -1 # 1 = right, -1 = left

func _physics_process(delta):
	# Turn around if a wall is detected
	if wall_ray.is_colliding() or !floor_ray.is_colliding():
			turn_around()

	var speed = patrol_speed

	if player_ray.is_colliding():
		var collider = player_ray.get_collider()

		if collider.name == "Player":
			speed = chase_speed
			sprite.play("agro")
		else:
			sprite.play("default")
	else:
		sprite.play("default")

	velocity.x = direction * speed
	move_and_slide()


func turn_around():
	direction *= -1

	# Flip the entire enemy, including all RayCast2Ds
	scale.x *= -1
