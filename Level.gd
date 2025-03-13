extends Node2D

var ABYDOS_STUDENTS = ["Serika", "Hoshino", "Shiroko", "Nonomi", "Ayane"]
var GEHENNA_STUDENTS = ["Hina", "Satsuki", "Iori"] #@TODO completar

const PLAYER_SCENE = preload("res://players/player2.tscn")

var spawnPositions = [
	Vector2(43, 495),
	Vector2(43, 547),
	Vector2(43, 593),
	Vector2(43, 643),
	Vector2(43, 691),
	Vector2(43, 739),
	Vector2(43, 786),
	Vector2(43, 835),
	Vector2(43, 880),
	Vector2(43, 928),
	Vector2(43, 978),
	]
	
	# num_players: scene,
var startPlatforms = {
	2: "res://environment/tileset/start_platform_scenes/2_players_platforms.tscn",
	3: "res://environment/tileset/start_platform_scenes/3_players_platforms.tscn",
	4: "res://environment/tileset/start_platform_scenes/4_players_platforms.tscn",
	5: "res://environment/tileset/start_platform_scenes/5_players_platforms.tscn",
	8: "res://environment/tileset/start_platform_scenes/8_players_platforms.tscn",
	9: "res://environment/tileset/start_platform_scenes/9_players_platforms.tscn",
	10:"res://environment/tileset/start_platform_scenes/10_players_platforms.tscn",
}

var startSpawnsQty = {
	2: [spawnPositions[2],spawnPositions[6]],
	3: [spawnPositions[1],spawnPositions[4],spawnPositions[7]],
	4: [spawnPositions[1],spawnPositions[3],spawnPositions[5],spawnPositions[7]],
	5: [spawnPositions[0],spawnPositions[2],spawnPositions[4],spawnPositions[6],spawnPositions[8]],
	8: [spawnPositions[1],spawnPositions[2],spawnPositions[3],spawnPositions[4],spawnPositions[5],spawnPositions[6],spawnPositions[7],spawnPositions[8]],
	9: [spawnPositions[0],spawnPositions[1],spawnPositions[2],spawnPositions[3],spawnPositions[4],spawnPositions[5],spawnPositions[6],spawnPositions[7],spawnPositions[8]],
	10:[spawnPositions[0],spawnPositions[1],spawnPositions[2],spawnPositions[3],spawnPositions[4],spawnPositions[5],spawnPositions[6],spawnPositions[7],spawnPositions[8],spawnPositions[9]],
}

#var abydosTextures = {
#	"Shiroko": preload("res://players/textures/abydos/Shiroko.png"),
#	"Hoshino": preload("res://players/textures/abydos/Hoshino.png"),
#	"Serika": preload("res://players/textures/abydos/Serika.png"),
#	"Nonomi": preload("res://players/textures/abydos/Nonomi.png"),
#	"Ayane": preload("res://players/textures/abydos/Ayane.png"),
#}

func getOneSchoolTextures(studentList: Array, school: String):
	var textures = {}
	for i in studentList.size():
		# @TODO remove ´load´ and only keep strings
		textures[studentList[i]] = load("res://players/textures/" + school + "/" + studentList[i] + ".png")
	print(textures)
	return textures

func getTextures(studentsList: Array, texturesList: Array):
	var textures = {}
	for i in studentsList.size():
		for j in texturesList.size():
			if texturesList[j].has(studentsList[i]):
				textures[studentsList[i]] = texturesList[j][studentsList[i]]
	print('result: ',textures)
	return textures

#func spawn_abydos_school():
#	for i in ABYDOS_STUDENTS.size():
#		spawn_player(startSpawnsQty[ABYDOS_STUDENTS.size()][i], abydosTextures[ABYDOS_STUDENTS[i]])
	
#	spawn_player(spawnPositions[0], abydosTextures["Serika"])
#	spawn_player(spawnPositions[1], abydosTextures["Hoshino"])
#	spawn_player(spawnPositions[2], abydosTextures["Shiroko"])
#	spawn_player(spawnPositions[3], abydosTextures["Nonomi"])
#	spawn_player(spawnPositions[4], abydosTextures["Ayane"])
#	spawn_player(spawnPositions[5], abydosTextures["Serika"])
#	spawn_player(spawnPositions[6], abydosTextures["Hoshino"])
#	spawn_player(spawnPositions[7], abydosTextures["Shiroko"])
#	spawn_player(spawnPositions[8], abydosTextures["Nonomi"])
#	spawn_player(spawnPositions[9], abydosTextures["Ayane"])
#	spawn_player(spawnPositions[10], abydosTextures["Ayane"])

func spawn_custom(studentList: Array, textureList: Dictionary):
	for i in studentList.size():
		spawn_player(startSpawnsQty[studentList.size()][i], textureList[studentList[i]])
			# @TODO add ´load´ to the string on 2nd parameter

func _ready():
	# Abydos
	#spawn_abydos_school()
	#var abydosTextures = getOneSchoolTextures(ABYDOS_STUDENTS, "abydos")
	#spawn_custom(ABYDOS_STUDENTS, abydosTextures)
	
	# Change accordingly
	var studentsList = ["Serika", "Hoshino", "Shiroko", "Nonomi", "Ayane", "Hina", "Satsuki", "Iori"]
	#var school = "abydos"
	
	var xabydosTextures = getOneSchoolTextures(ABYDOS_STUDENTS, "abydos")
	var xgehennaTextures = getOneSchoolTextures(GEHENNA_STUDENTS, "gehenna")
	var allTextures = [xabydosTextures, xgehennaTextures]
	var textures = getTextures(studentsList, allTextures)

	
	# Generic
	spawn_custom(studentsList, textures)
	
	var position = get_tree().get_nodes_in_group("players").size()
	# Load coresponding starter platforms depending on "players" group size
	var platforms = load(startPlatforms[position]).instance()
	add_child(platforms)
	

func spawn_player(position: Vector2, texture: Texture):
	var player = PLAYER_SCENE.instance()
	player.position = position
	add_child(player)
	player.set_texture(texture) # Asigna la textura antes de añadirlo a la escena
	player.make_trail()
	player.add_to_group("players")
