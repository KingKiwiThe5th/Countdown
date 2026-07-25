extends Node

const DEFAULT_TIME = 30

var countdown_time : int = 30
var lifts: Array = []
func countdown_reset(new_time):
	countdown_time = new_time

func reset():
	lifts.clear()
	countdown_time = DEFAULT_TIME
