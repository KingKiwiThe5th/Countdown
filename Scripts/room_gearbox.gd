extends Node2D

@export_enum("right","left") var direction = 1
@onready var press_e: Label = $Area2D/PressE
@export var corresponding_door_id: int

var corresponding_door
var full

func _ready() -> void:
	if direction == 0:
		scale.x *= -1
		press_e.scale.x *= -1
		press_e.position.x += 59

	await get_tree().create_timer(0.5).timeout
	for lift in Countdown.lifts:
		if lift.lift_id == corresponding_door_id:
			corresponding_door = lift

func _process(delta: float) -> void:
	if full:
		full = false
		corresponding_door.unlock()
