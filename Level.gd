extends Node2D

const PLAYER_SCENE = preload("res://players/player2.tscn") # Carga la escena del jugador
var spawnPositions = {
	"1x1": Vector2(43,495),
	"2x1": Vector2(43,570),
	"3x1": Vector2(43,634),
	"4x1": Vector2(43,670),
	"5x1": Vector2(43,732),
}
var abydosTextures = {
	"Shiroko": preload("res://players/textures/abydos/shiroko.png"),
	"Hoshino": preload("res://players/textures/abydos/hoshino.png"),
	"Serika": preload("res://players/textures/abydos/serika.png"),
	"Nonomi": preload("res://players/textures/abydos/nonomi.png"),
	"Ayane": preload("res://players/textures/abydos/ayane.png"),
}

func spawn_abydos_school():
	spawn_player(Vector2(43, 495), abydosTextures["Serika"])
	spawn_player(Vector2(43, 547), abydosTextures["Hoshino"])
	spawn_player(Vector2(43, 593), abydosTextures["Shiroko"])
	spawn_player(Vector2(43, 643), abydosTextures["Nonomi"])
	spawn_player(Vector2(43, 691), abydosTextures["Ayane"])
	spawn_player(Vector2(43, 739), abydosTextures["Serika"])
	spawn_player(Vector2(43, 786), abydosTextures["Hoshino"])
	spawn_player(Vector2(43, 835), abydosTextures["Shiroko"])
	spawn_player(Vector2(43, 880), abydosTextures["Nonomi"])
	spawn_player(Vector2(43, 928), abydosTextures["Ayane"])
	spawn_player(Vector2(43, 978), abydosTextures["Ayane"])

func _ready():
	# Abydos
	spawn_abydos_school()
	
func spawn_player(position: Vector2, texture: Texture):
	var player = PLAYER_SCENE.instance()
	player.position = position
	add_child(player)
	player.set_texture(texture) # Asigna la textura antes de añadirlo a la escena
	player.make_trail()
	player.add_to_group("players")
