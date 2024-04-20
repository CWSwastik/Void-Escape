extends AnimatableBody2D

var pivot

func _ready():
	pivot = global_position
	
func _physics_process(delta):
	global_position = pivot
