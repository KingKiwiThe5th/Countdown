extends Node2D

@export var door_id: int
@onready var sprite: Sprite2D = $Sprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	Countdown.lifts.append(self)

func unlock():
	sprite.visible = false
	collision_shape.disabled = true
