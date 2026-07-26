#extends Area2D
#
#func _on_body_entered(body: Node2D) -> void:
	#print ("good")
	#if body.name == "Player":
		#print ("gooder")
		#body.die()
extends Area2D

@onready var timer: Timer = $Timer
@onready var collider: Node = null
var has_triggered := false
var shrinky: CharacterBody2D

func _on_body_entered(body: Node2D) -> void:
	if has_triggered or body.name != "Player":
		return

	has_triggered = true
	shrinky = body

	Engine.time_scale = 0.5
	shrinky.velocity = Vector2.ZERO
	timer.start()

func _on_timer_timeout():
	Engine.time_scale = 1.0

	if is_instance_valid(shrinky):
		shrinky.die()

	shrinky = null
	has_triggered = false
	
