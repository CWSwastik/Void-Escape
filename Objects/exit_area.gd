extends Area2D

@export var target_level : PackedScene

func _on_body_entered(body):
	if body.name == "Player":
		Global.update_score()
		get_tree().change_scene_to_packed(target_level)
		
		

	
