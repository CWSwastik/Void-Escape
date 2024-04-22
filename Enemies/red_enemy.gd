extends CharacterBody2D

@export var SPEED = 250
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


var spawn_location

func _ready():
	spawn_location = self.global_position

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
		hack_label.visible = false
		set_collision_layer_value(1, false)
		Global.score += 50
		
	
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if hacked:
		SPRITE.animation = "Hacked"
		move_and_slide()
		return
		
	if chase:
		var dir = (player.position - self.position).normalized()
		
		SPRITE.animation = "Walk"
		velocity.x = dir.x * SPEED
		
		if dir.x < 0:
			face_left = true
		else:
			face_left = false
		if (player.position - self.position).length() > 300 or abs(player.position.y - self.position.y) > 150:
			chase = false
			SPRITE.animation = "Idle"
	elif (spawn_location - self.global_position).length() > 25 and not hacked:
		var dir = (spawn_location - self.global_position).normalized()
		
		SPRITE.animation = "Walk"
		velocity.x = dir.x * SPEED / 10
		#if dir.x < 0:
			#face_left = true
		#else:
			#face_left = false		
	else:
		velocity.x = 0
		SPRITE.animation = "Idle"
	
	
	SPRITE.flip_h = velocity.x < 0
	if face_left and velocity.x == 0:
		SPRITE.flip_h = true
		
	if SPRITE.flip_h:
		player_detection.position.x = -70
		player_killer.position.x = -2.5
		player_hack.position.x = 5
	else:
		player_detection.position.x = 70
		player_killer.position.x = 2.5
		player_hack.position.x = -5

	move_and_slide()


func _on_player_hack_body_entered(body):

	if body.name == "Player" and not hacked:
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
		hacked = true
		
		
func kill():
	var _particle = preload("res://Objects/DeathParticles.tscn").instantiate()
	_particle.position = global_position
	_particle.rotation = global_rotation
	_particle.emitting = true
	get_tree().current_scene.add_child(_particle)
	hacked = true
	velocity.x = 0
	await get_tree().create_timer(0.2).timeout
	queue_free()


