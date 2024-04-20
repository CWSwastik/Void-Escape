extends CharacterBody2D

var SPEED = 50
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var player = $"../../Player"
var chase = false
@onready var SPRITE = $AnimatedSprite2D

func _on_player_detection_body_entered(body):
	if body.name == "Player":
		chase = true
		
func _on_player_detection_body_exited(body):
	if body.name == "Player":
		chase = false
		SPRITE.animation = "Idle"
		
func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if chase:
		var dir = (player.position - self.position).normalized()
		
		SPRITE.animation = "Walk"
		velocity.x = dir.x * SPEED
	else:
		velocity.x = 0
	SPRITE.flip_h = velocity.x < 0
	
	move_and_slide()
