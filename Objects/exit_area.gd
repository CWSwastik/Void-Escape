extends Area2D

@export var target_level : PackedScene
@export var last_level: bool = false

func _on_body_entered(body):
		
	if body.name == "Player":
		GameAudios.stop_all_audio()
		if last_level:
			Global.escaped = true
			Global.score += 250
		Global.update_score()
		get_tree().change_scene_to_packed(target_level)
		

	
