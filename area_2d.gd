extends Area2D

@export var dialogue_name : String



func _on_body_entered(body: Node2D) -> void:
	var collider = body
	if collider.name == "Player":
		Dialogic.start(dialogue_name)
		queue_free()
