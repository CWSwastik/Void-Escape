extends CharacterBody2D

var SPEED = 230
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var chase = false
var hacked = false
var is_hackable = false

@onready var player = $"../../Player"
@onready var SPRITE = $AnimatedSprite2D
@onready var player_detection = $PlayerDetection/CollisionShape2D
@onready var player_killer = $PlayerKill/CollisionShape2D
@onready var player_hack = $PlayerHack/CollisionShape2D
@onready var hack_label = $Label

@export var face_left: bool = false 

func _on_player_detection_body_entered(body):
	if body.name == "Player" and not hacked:
		chase = true
		
func _on_player_detection_body_exited(_body):
	pass
		
func _physics_process(delta):
	if Input.is_action_pressed("hack") and is_hackable:
		hacked = true
		is_hackable = false
		SPRITE.animation = "Hacked"
		
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if chase:
		var dir = (player.position - self.position).normalized()
		
		SPRITE.animation = "Walk"
		velocity.x = dir.x * SPEED
		if dir.x < 0:
			face_left = true
		else:
			face_left = false
		if (player.position - self.position).length() > 250:
			chase = false
			SPRITE.animation = "Idle"
	else:
		velocity.x = 0
	
	SPRITE.flip_h = velocity.x < 0
	if face_left and velocity.x == 0:
		SPRITE.flip_h = true
		
	if SPRITE.flip_h:
		player_detection.position.x = -50
		player_killer.position.x = -2.5
		player_hack.position.x = 5
	else:
		player_detection.position.x = 50
		player_killer.position.x = 2.5
		player_hack.position.x = -5

	move_and_slide()


func _on_player_hack_body_entered(body):

	if body.name == "Player":
		is_hackable = true
		hack_label.visible = true
		
func _on_player_hack_body_exited(body):
	if body.name == "Player":
		is_hackable = false
		hack_label.visible = false



func _on_player_kill_body_entered(body):
	if body.name == "Player" and not hacked:
		body.killed = true
		chase = false
		SPRITE.animation = "Idle"
		


