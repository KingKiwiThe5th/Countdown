extends Node2D

@onready var base_position :Vector2 = position

func _process(delta: float) -> void:
	if LevelReset.reset_gears:
		LevelReset.reset_gears = false
		position = base_position
