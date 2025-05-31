extends Node


var player_score: float = 0

var leaderboard_data: Dictionary = {}


func reset_game_state():
	player_score = 0
	
	var player: Player = get_tree().get_first_node_in_group("Player")
	player.reset()
	
	var flowers: = get_tree().get_nodes_in_group("Flower")
	for obj in flowers:
		if obj is NectarSource:
			obj.reset()
