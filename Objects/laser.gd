extends Area2D
class_name Laser

var on = true:
	set (value):
		on = value
		self.visible = on
		

func _on_body_entered(body):
	if on:
		if body.name == "Player":
			body.killed = true
		elif "Enemy" in body.name:
			body.kill()
	
