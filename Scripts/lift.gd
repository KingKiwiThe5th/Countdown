extends Node2D

@export var target : Vector2
@export var time : float
@export var lift_id: int
@onready var base_position = position

func _ready() -> void:
	Countdown.lifts.append(self)

func move():
	var tween = create_tween()
	tween.tween_property(self,"position",target,time)
	moved = true

var moved = false
func _process(delta: float) -> void:
	if player_on and moved:
		var tween = create_tween()
		tween.tween_property(self,"position",base_position,time)

var player_on
func _on_player_detector_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player_on = true


func _on_player_detector_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player_on = false
		var tween = create_tween()
		tween.tween_property(self,"position",target,time)
