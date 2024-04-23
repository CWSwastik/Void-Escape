extends Control

func _ready():
	if Global.escaped:
		$Label.text = "You Escaped!"
		$Label.position.x -= 70
	
	$Label2.text = "Score: " + str(Global.score)
	
	print(Global.score, Global.old_high_score)
	if Global.score > Global.old_high_score:
		$Label3.visible = true
	else:
		$SubmitButton.text = "Go back"
		$LineEdit.visible = false
		
	if LootLocker.player_name != "":
		$LineEdit.text = LootLocker.player_name

func _on_line_edit_text_submitted(new_text):
	LootLocker._change_player_name(new_text)
	
func _on_submit_button_pressed():
	if LootLocker.player_name != $LineEdit.text:
		LootLocker._change_player_name($LineEdit.text)
	if Global.score == Global.high_score:
		await LootLocker._upload_score()
	Global.score = 0
	get_tree().change_scene_to_file("res://mainmenu.tscn")
