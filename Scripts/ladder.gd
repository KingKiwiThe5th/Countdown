extends Node2D

@export_enum("up","middle","down") var type: int
@onready var ladder_type: AnimatedSprite2D = $ladderType

func _ready() -> void:
	# in the enum "0" -> up, "1" -> middle, "2" -> down
	if type == 0:
		ladder_type.play("up")
	elif type == 1:
		ladder_type.play("middle")
	else:
		ladder_type.play("down")
