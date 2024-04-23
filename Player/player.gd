extends CharacterBody2D


const SPEED = 200.0
const DASH = 500.0
const JUMP_VELOCITY = -435.0
const MAX_DASH_DURATION = 10 # frames
const MAX_ATTACK_DURATION = 18 # frames

const MAX_DASH_COOLDOWN = 100 # frames
const MAX_ATTACK_COOLDOWN = 50 # frames

var killed = false


var facing_left = false
var running = false
var dashing = false
var attacking = false
var played_kill_audio = false
var dash_duration = MAX_DASH_DURATION
var attack_duration = MAX_ATTACK_DURATION

var dash_cooldown = MAX_DASH_COOLDOWN
var attack_cooldown = MAX_ATTACK_COOLDOWN


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var SPRITE = $AnimatedSprite2D
@onready var enemy_killer = $EnemyKiller/CollisionShape2D

# special powers
var can_jump = "jump" in Global.player_abilities
var can_dash = "dash" in Global.player_abilities
var can_attack = "attack" in Global.player_abilities


var enemies_in_kill_range = []

func _physics_process(delta):
	

	$PlayerStats/DashPanel.visible = can_dash
	$PlayerStats/AttackPanel.visible = can_attack	
	
	$PlayerStats/DashPanel/ProgressBar.value = 100 - 100*dash_cooldown/MAX_DASH_COOLDOWN
	$PlayerStats/AttackPanel/ProgressBar.value = 100 - 100*attack_cooldown/MAX_ATTACK_COOLDOWN
	
	if killed:
		if not played_kill_audio:
			GameAudios.player_death()
			played_kill_audio = true
		SPRITE.animation = "Death"
		velocity.x = 0
		if velocity.y < 0:
			velocity.y = 50
		move_and_slide()
		return
		
	if len(enemies_in_kill_range) != 0 and attacking:
		for e in enemies_in_kill_range:
			e.kill()
		
		
	if not is_on_floor():
		GameAudios.stop_run()
		if (abs(velocity.x) > 500): # TODO: Figure this out
			SPRITE.animation = "JumpFlip"
		else:
			SPRITE.animation = "Jump"
	elif (abs(velocity.x) > 1):
		SPRITE.animation = "Run"
		GameAudios.run()
	elif not dashing and not attacking:
		SPRITE.animation = "Idle"

	if (abs(velocity.x) <= 1):
		GameAudios.stop_run()

	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor() and can_jump:
		velocity.y = JUMP_VELOCITY
		
	if dash_duration < 0:
		dashing = false
	
	var direction = Input.get_axis("move_left", "move_right")
	var sp = SPEED
	
	if Input.is_action_just_pressed("dash") and can_dash and dash_cooldown < 0:
		sp = DASH
		dashing = true
		dash_duration = MAX_DASH_DURATION
		dash_cooldown = MAX_DASH_COOLDOWN
		SPRITE.animation = "Dash"
		GameAudios.dash()
		
	if dashing:
		sp = DASH
		dash_duration -= 1
		if facing_left:
			velocity.x = -sp
		else:
			velocity.x = sp
	else:
		dash_cooldown -= 1
		
		
	if not Global.dialogue_played:
		sp = 0
	
	if direction and not attacking:
		velocity.x = direction * sp
		if direction < 0:
			facing_left = true
		else:
			facing_left = false
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		

	if Input.is_action_just_pressed("attack") and can_attack and is_on_floor() and attack_cooldown < 0:
		SPRITE.animation = "Attack" + str(randi_range(1,2))
		attacking = true
		GameAudios.attack()
		attack_duration = MAX_ATTACK_DURATION
		attack_cooldown = MAX_ATTACK_COOLDOWN
		velocity.x = 0

	if attacking:
		attack_duration -= 1
	else:
		attack_cooldown -= 1
	
	if attack_duration < 0:
		attacking = false
	
	move_and_slide()
	
	
	SPRITE.flip_h = velocity.x < 0
	if facing_left and velocity.x == 0:
		SPRITE.flip_h = true

	if SPRITE.flip_h:
		enemy_killer.position.x = -50
	else:
		enemy_killer.position.x = 50

func _on_animated_sprite_2d_animation_finished():
	if SPRITE.animation == "Death":
		await get_tree().create_timer(1.0).timeout
		get_tree().change_scene_to_file("res://score_screen.tscn")
		


func _on_enemy_killer_body_entered(body):
	if body.name.contains("RedEnemy"):
		if attacking:
			body.kill()
		else:
			enemies_in_kill_range.append(body)


func _on_enemy_killer_body_exited(body):
	if body.name.contains("RedEnemy"):
		enemies_in_kill_range.erase(body)
