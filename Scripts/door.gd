extends Node2D

@export var door_id: int
@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	Countdown.lifts.append(self)

func unlock():
	sprite.visible = false
