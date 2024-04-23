extends CanvasLayer

func _physics_process(delta):
	if Global.dialogue_played:
		$Control/Label.text = "Time: " + Global.get_time() + "\nScore: " + str(Global.score)
