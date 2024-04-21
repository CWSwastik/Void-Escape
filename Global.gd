extends Node

var time_elapsed = 0
var player_abilities = [] # jump, dash, attack

@onready var game_start_time = Time.get_ticks_msec()

func set_game_start_time():
	game_start_time = Time.get_ticks_msec()

func get_time():
	var current_time = Time.get_ticks_msec() - game_start_time
	var mins = str(current_time/1000/60)
	var secs = str(current_time/1000%60)

	if int(mins) < 10:
		mins = "0" + str(mins)
	if int(secs) < 10:
		secs = "0" + str(secs)

	
	

	return ((mins) + ":" + (secs))
