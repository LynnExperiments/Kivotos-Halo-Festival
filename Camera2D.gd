extends Camera2D

func _process(delta):
	var players = get_tree().get_nodes_in_group("players")
	if players.size() == 0:
		return
	
	# Camera to follow the leader
	var leader = players[0]
	for player in players:
		if player.global_position.x > leader.global_position.x:
			leader = player  

	position = position.linear_interpolate(leader.global_position, 5 * delta)
