extends Area2D

@onready var base_position: Vector2 = global_position
@onready var anim: AnimatedSprite2D = $"../AnimatedSprite2D"
@onready var label: Label = $PressE
var hasBody
var gear_count := 0
var player
var full

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("select") and hasBody and player.hasGear:
		# changing animations
		if gear_count == 0:
			anim.play("one")
			gear_count += 1
		elif gear_count == 1:
			anim.play("two")
			gear_count += 1
		elif gear_count == 2:
			anim.play("full")
			get_parent().full = true
			full = true
			label.visible = false
			player.base_position = base_position
		var gear = player.gears.pop_front()
		player.hasGear = !player.gears.is_empty()
		if is_instance_valid(gear):
			gear.consume()

func _on_body_entered(body: Node2D) -> void:
	# checking valid terms for the player
	if body.name == "Player":
		player = body
		if player.hasGear and !full:
			label.visible = true
			hasBody = true

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player = null
		label.visible = false
		hasBody = false
