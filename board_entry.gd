extends HBoxContainer

var player_name = "Name"
var player_score = "Score"

func _ready():
	$NameLabel.text = player_name
	$ScoreLabel.text = str(player_score)
