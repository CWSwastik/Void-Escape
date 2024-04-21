extends CanvasLayer

func _physics_process(delta):
	$Control/Label.text = Global.get_time()
