extends Node2D

@export var countdown_time :int = 20
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D


var used = false
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player" and !used:
		used = true
		anim.play("activated")
		Countdown.countdown_reset(countdown_time)
