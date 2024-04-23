extends CanvasLayer

var text

func _ready():
	self.visible = false
	
	if Global.dialogue_played:
		return
		
	text = $Intro/Label.text
	$Intro/Label.text = ""
	
	await get_tree().create_timer(1).timeout
	self.visible = true
	GameAudios.play_dialogue()
	for i in text:
		$Intro/Label.text += i
		await get_tree().create_timer(0.055).timeout

	Global.dialogue_played = true
	Global.set_game_start_time()
	await get_tree().create_timer(2).timeout
	self.visible = false
