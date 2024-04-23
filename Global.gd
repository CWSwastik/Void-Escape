extends Node

var score = 0:
	set (val):
		score = val
		if val > high_score:
			old_high_score = high_score
			high_score = val
var high_score = 0
var old_high_score = 0
var player_abilities = [] # jump, dash, attack
var dialogue_played = true
var escaped = false

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

func update_score():
	var elapsed = Time.get_ticks_msec() - game_start_time
	var secs = (elapsed/1000)
	if secs > 15*60:
		score += 100
	else:
		score += 15*60-secs + 100
		
	game_start_time = Time.get_ticks_msec()
	
