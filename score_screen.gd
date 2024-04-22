extends Control

func _ready():
	$Label2.text = "Score: " + str(Global.score)
	if LootLocker.player_name != "":
		$LineEdit.text = LootLocker.player_name

func _on_line_edit_text_submitted(new_text):
	LootLocker._change_player_name(new_text)
	
func _on_submit_button_pressed():
	await LootLocker._upload_score()
	get_tree().change_scene_to_file("res://mainmenu.tscn")
