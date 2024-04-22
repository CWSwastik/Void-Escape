extends StaticBody2D

@export var laser: Laser
@export var other_lasers: Array[Laser] = []

@onready var SPRITE = $AnimatedSprite2D

var toggled_on = true

func _on_player_detector_body_entered(body):
	if body.name == "Player":
		toggled_on = not toggled_on
		laser.on = toggled_on
		for l in other_lasers:
			l.on = toggled_on
		SPRITE.animation = "pressed"


func _on_player_detector_body_exited(body):
	if body.name == "Player":
		SPRITE.animation = "unpressed"
