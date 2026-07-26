extends Node2D

@export_enum("good","bad") var type = "good"
@export var countdown_time :int = 20
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var bad_label: Label = $Bad_label


var used = false
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player" and !used:
		used = true
		if type == "good":
			anim.play("activated")
			Countdown.countdown_time += 20
		else:
			anim.play("activated_bad")
			Countdown.countdown_time -= 3
			bad_label.visible = true
			var tween = create_tween()
			tween.tween_property(bad_label,"modulate:a",0.0,1.0)
