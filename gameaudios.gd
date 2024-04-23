extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	play_bg_music() 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func play(node):
	if not node.playing:
		node.play()

func button_pressed():
	play($ButtonClick)

func play_bg_music():
	play($BGMusic)

func run():
	play($Run)

func explosion():
	play($Explosion)
	
func hack():
	play($Hack)
	
func player_death():
	play($Death)
	stop_run()
	
func dash():
	play($Dash)

func stop_run():
	$Run.stop()

func attack():
	play($Attack)
	
func elevator():
	play($Elevator)
	
func stop_elevator():
	$Elevator.stop()
	
func play_dialogue():
	$Dialogue.play()

func stop_all_audio():
	stop_run()
	stop_elevator()
	
func robot_walk():
	play($RobotWalk)
	
func stop_robot_walk():
	$RobotWalk.stop()
