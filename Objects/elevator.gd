extends AnimatableBody2D

@export var offset: Vector2
var pivot 
var target


func _ready():
	pivot = global_position
	target = global_position
	
func _physics_process(_delta):
	global_position.y = move_toward(global_position.y, target.y, 1)
	if global_position.y == target.y:
		GameAudios.stop_elevator()
	# TODO: fix entity under elevator bug
	
func _on_player_detector_body_entered(body):
	if body.name == "Player" and global_position == target:
		if global_position == pivot:
			target = pivot + offset
		else:
			target = pivot
		
		GameAudios.elevator()


func _on_player_detector_body_exited(body):
	if body.name == "Player":
		target = global_position
		GameAudios.stop_elevator()
