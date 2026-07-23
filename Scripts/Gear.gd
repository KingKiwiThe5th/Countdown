extends Area2D

var player 

func _process(delta):
	var check_bodies = get_overlapping_bodies()
	for body in check_bodies:
		if body.name == "Player":
			player = body
			follow()

func follow():
	player.velocity.y = -300
