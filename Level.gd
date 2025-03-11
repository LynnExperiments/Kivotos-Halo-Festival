extends Node2D

const PLAYER_SCENE = preload("res://players/player2.tscn") # Carga la escena del jugador
var abydosTextures = {
	"Shiroko": preload("res://players/textures/abydos/shiroko.png"),
	"Hoshino": preload("res://players/textures/abydos/hoshino.png"),
	"Serika": preload("res://players/textures/abydos/serika.png"),
	"Nonomi": preload("res://players/textures/abydos/nonomi.png"),
	"Ayane": preload("res://players/textures/abydos/ayane.png"),
}

func spawn_abydos_school():
	spawn_player(Vector2(25, 850), abydosTextures["Shiroko"])
	spawn_player(Vector2(25, 630), abydosTextures["Hoshino"])
	spawn_player(Vector2(25, 535), abydosTextures["Serika"])
	spawn_player(Vector2(130, 850), abydosTextures["Nonomi"])
	spawn_player(Vector2(130, 630), abydosTextures["Ayane"])

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
