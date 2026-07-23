extends Area2D

var player

func _process(delta):
	var check_bodies = get_overlapping_bodies()
	for body in check_bodies:
		if body.name == "Player":
			player = body
			climb()

func climb():
	if Input.is_action_pressed("climb") or Input.is_action_pressed("arrow_climb"):
		print("ladder")
		player.velocity.y = -150
	elif Input.is_action_pressed("climb_down") or Input.is_action_pressed("arrow_climb_down"):
		print("ladder")
		player.velocity.y = 100
