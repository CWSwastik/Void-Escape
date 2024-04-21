extends Area2D

var is_usable = false
var using = false
@onready var label = $Label
@onready var hack_menu = $HackMenu
@onready var player = $"../Player"


func _on_body_entered(body):
	if body.name == "Player":
		is_usable = true
		label.visible = true
		
func _on_body_exited(body):
	if body.name == "Player":
		is_usable = false
		using = false
		label.visible = false
		
func _physics_process(delta):
	if is_usable and Input.is_action_just_pressed("hack"):
		print("Using computer")
		using = true
		
		label.visible = false
		
	if using:
		hack_menu.visible = true
	else:
		hack_menu.visible = false
		


func _on_dash_button_toggled(toggled_on):
	player.can_dash = toggled_on


func _on_jump_button_toggled(toggled_on):
	player.can_jump = toggled_on
