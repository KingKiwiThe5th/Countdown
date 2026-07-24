extends Camera2D

var locked_x: float

func _ready():
	locked_x = global_position.x

func _process(_delta):
	global_position.x = locked_x
