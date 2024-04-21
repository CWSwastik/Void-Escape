extends HBoxContainer

var player_name = "Anonymouse"
var player_score = 0

func _ready():
	$NameLabel.text = player_name
	$ScoreLabel.text = str(player_score)
