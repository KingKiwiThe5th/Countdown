extends Area2D

@onready var base_position: Vector2 = global_position
var player = null
var following = false
# attempt to make it follow after each other. didnt really work. might come back to it
var leader = null
var using = null
var resetting = false
func _process(delta):
	var check_bodies = get_overlapping_bodies()
	for body in check_bodies:
		if body.name == "Player" && !following :
			player = body
			following = true
			print(player.gears)
			player.gears.append(self)
			if player.gears.size() > 0:
				leader = player.gears[player.gears.size() - 1]
				player.hasGear = true
			else:
				leader = player
	if resetting:
		if resetting:
			global_position = global_position.lerp(base_position, delta * 6)
			if global_position.distance_to(base_position) < 2:
				global_position = base_position
				resetting = false


			
	if following:
		var slot = player.gears.find(self)
		var offset = (slot + 1) * 20
		var target = player.global_position + Vector2(offset * player.facing, 0)
		global_position = global_position.lerp(target, delta * 6)
	#if using:
		
func consume():
	following = false
	player = null
	print ("done")
	queue_free()
	
func reset():
	following = false
	player = null
	resetting = true
		
		# player.gears.erase(self)
		# following = false
		# player = null
