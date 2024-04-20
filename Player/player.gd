extends CharacterBody2D


var killed = false
const SPEED = 200.0
const JUMP_VELOCITY = -435.0
@onready var SPRITE = $AnimatedSprite2D
var facing_left = false
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	if killed:
		SPRITE.animation = "Death"
		velocity.x = 0
		if velocity.y < 0:
			velocity.y = 0
		move_and_slide()
		return
		
	if not is_on_floor():
		if (abs(velocity.x) > 500): # TODO: Figure this out
			SPRITE.animation = "JumpFlip"
		else:
			SPRITE.animation = "Jump"
	elif (abs(velocity.x) > 1):
		SPRITE.animation = "Run"
	else:
		SPRITE.animation = "Idle"
	

	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
		if direction < 0:
			facing_left = true
		else:
			facing_left = false
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)


	move_and_slide()
	
	
	SPRITE.flip_h = velocity.x < 0
	if facing_left and velocity.x == 0:
		SPRITE.flip_h = true
