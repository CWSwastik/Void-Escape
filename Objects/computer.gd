extends Area2D

var is_usable = false
var using = false
@onready var label = $Label
@onready var hack_menu = $HackMenu
@onready var player = $"../Player"

@export var show_jump: bool = false
@export var show_dash: bool = false
@export var show_attack: bool = false

func _on_body_entered(body):
	if body.name == "Player":
		is_usable = true
		label.visible = true
		
func _on_body_exited(body):
	if body.name == "Player":
		is_usable = false
		using = false
		label.visible = false
		
func _physics_process(_delta):
	if is_usable and Input.is_action_just_pressed("hack"):
		print("Using computer")
		using = true
		
		label.visible = false
		
	if using:
		hack_menu.visible = true
		$HackMenu/PanelContainer/Panel/JumpLabel.visible = show_jump
		$HackMenu/PanelContainer/Panel/DashLabel.visible = show_dash
		$HackMenu/PanelContainer/Panel/AttackLabel.visible = show_attack
	else:
		hack_menu.visible = false
		


func _on_dash_button_toggled(toggled_on):
	player.can_dash = toggled_on
	print("Player Dash", toggled_on)


func _on_jump_button_toggled(toggled_on):
	player.can_jump = toggled_on
	print("Player Jump", toggled_on)

func _on_attack_button_toggled(toggled_on):
	player.can_attack = toggled_on
	print("Player Attack", toggled_on)
