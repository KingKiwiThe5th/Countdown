extends Node2D

@export_enum("right","left") var direction
@onready var press_e: Label = $Area2D/PressE

# needs fixing, label position off
func _ready() -> void:
	if direction == 0:
		scale.x *= -1
		press_e.scale.x *= -1
