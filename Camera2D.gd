extends Camera2D

func _process(delta):
	var players = get_tree().get_nodes_in_group("players")  # 🔥 Obtener jugadores en cada frame
	if players.size() == 0:
		#print("out")
		return  # Si no hay jugadores, no hacemos nada

	var leader = players[0]  # Inicializamos con el primer jugador
	for player in players:
		if player.global_position.x > leader.global_position.x:
			leader = player  # Si encontramos un jugador más adelante en X, lo asignamos como líder

	# Actualizamos la posición de la cámara para que siga al líder suavemente
	position = position.linear_interpolate(leader.global_position, 5 * delta)
