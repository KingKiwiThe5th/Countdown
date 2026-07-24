extends Area2D

func _on_body_entered(body: Node2D) -> void:
	print ("good")
	if body.name == "Player":
		print ("gooder")
		body.die()
