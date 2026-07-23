extends Node2D

@export var target : Vector2
@export var time : float
func move():
	var tween = create_tween()
	tween.tween_property(self,"position",target,time)
