extends CanvasLayer

@onready var player = $"../Player"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Con/TouchJump.visible = player.can_jump
	$Con/TouchDash.visible = player.can_dash
	$Con/TouchAttack.visible = player.can_attack
