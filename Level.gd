extends Node2D

const PLAYER_SCENE = preload("res://players/player2.tscn") # Carga la escena del jugador
var textures = [
	preload("res://players/textures/abydos/shiroko.png"),
	preload("res://players/textures/abydos/hoshino.png"),
	preload("res://players/textures/abydos/serika.png")
]

func _ready():
	spawn_player(Vector2(25, 850), textures[0])
	spawn_player(Vector2(25, 750), textures[1])
	spawn_player(Vector2(25, 650), textures[2])

func spawn_player(position: Vector2, texture: Texture):
	var player = PLAYER_SCENE.instance()
	player.position = position
	add_child(player)
	player.set_texture(texture) # Asigna la textura antes de añadirlo a la escena
	player.make_trail()
	player.add_to_group("players")
