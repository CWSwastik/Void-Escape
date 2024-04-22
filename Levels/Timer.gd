extends CanvasLayer

func _physics_process(delta):
	$Control/Label.text = "Time: " + Global.get_time() + "\nScore: " + str(Global.score)
