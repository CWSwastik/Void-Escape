extends Area2D


func _on_body_entered(body):
	if body.name == "Player":
		body.killed = true
	elif "Enemy" in body.name:
		body.kill()
