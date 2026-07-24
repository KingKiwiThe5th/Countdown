#extends Area2D
#
#func _on_body_entered(body: Node2D) -> void:
	#if body.name == "Player":
		#body.die()
extends Area2D

@onready var timer: Timer = $Timer
@onready var collider: Node = null
var has_triggered := false
var shrinky: CharacterBody2D = null

func _on_body_entered(body: Node2D) -> void:
	if has_triggered or body.name != "Player":
		print("hit")
		return
		
	
	has_triggered = true
	shrinky = body as CharacterBody2D
	print("you died from killzone")
	
	
	# Freeze time and stop player movement BUT KEEP VISIBLE
	Engine.time_scale = 0.25
	if shrinky:
		shrinky.velocity = Vector2.ZERO
		# Character stays visible during death timer
	
	timer.start()

func _on_timer_timeout() -> void:
	Engine.time_scale = 1.0
	
	# Reset the killzone for future use
	has_triggered = false
	if collider:
		collider.set_deferred("disabled", false)
	shrinky.die()
	shrinky = null
	return
	
	
