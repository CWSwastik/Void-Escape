extends Control

func _ready():
	await LootLocker.wait_until_authorized()
	LootLocker._get_leaderboards(on_leaderboard_load)

func on_leaderboard_load(result, response_code, headers, body):

	const board_entry_scene = preload("res://board_entry.tscn")
	
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	
	# Print data
	print(json.get_data())
	
	for n in json.get_data().items.size():
		var entry = board_entry_scene.instantiate()
		entry.player_name = json.get_data().items[n].player.name
		entry.player_score = json.get_data().items[n].score
		$ScorePanel/ScrollContainer/PlayerList.add_child(entry)
