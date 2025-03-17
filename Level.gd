extends Node2D

var ABYDOS_STUDENTS = ["Serika", "Hoshino", "Shiroko", "Nonomi", "Ayane"]
var GEHENNA_STUDENTS = ["Makoto", "Satsuki", "Chiaki", "Iroha", "Ibuki", 
"Hina", "Ako", "Iori", "Chinatsu", "Aru", "Mutsuki", "Kayoko", "Haruka", 
"Haruna", "Junko", "Izumi", "Akari", "Fuuka", "Juri", "Sena", "Kasumi", 
"Megu", "Kirara", "Erika"]

#onready var minimap_camera = $ViewportContainer/Viewport/MinimapCamera
#onready var viewport = $ViewportContainer/Viewport
#onready var texture_rect = $UI/TextureRect
#onready var world_source = get_tree().current_scene

const PLAYER_SCENE = preload("res://players/player2.tscn")
const LEFT_BORDER = preload("res://environment/borders/b_left.tscn")
const TOP_BOTTOM_BORDERS = preload("res://environment/borders/top_and_bottom.tscn")

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

func get_level_center():
	var level_rect = $tilemap.get_used_rect()
	return level_rect.position + (level_rect.size / 2) * 64  

func getOneSchoolTextures(studentList: Array, school: String):
	var textures = {}
	for i in studentList.size():
		textures[studentList[i]] = "res://players/textures/" + school + "/" + studentList[i] + ".png"
	return textures

func getTextures(studentsList: Array, texturesList: Array):
	var textures = {}
	for i in studentsList.size():
		for j in texturesList.size():
			if texturesList[j].has(studentsList[i]):
				textures[studentsList[i]] = texturesList[j][studentsList[i]]
	return textures

func getBorders(school: String):
	var vertical_source = ""
	var horizontal_source = ""
	if(school):
		vertical_source = load("res://environment/borders/schools_textures/" + school + "/vertical.png")
		horizontal_source = load("res://environment/borders/schools_textures/" + school + "/horizontal.png")
	else:
		vertical_source = load("res://environment/borders/whiteTexture_big.png")
		horizontal_source = load("res://environment/borders/whiteTexture_horizontal.png")
	# Left border
	var left_border = LEFT_BORDER.instance()
	left_border.position = Vector2(0, 127)
	add_child(left_border)
	left_border.get_node("txt_b_left").set_texture(vertical_source)
	# Top and Bottom borders
	for i in 4:
		var top_bottom_borders = TOP_BOTTOM_BORDERS.instance()
		top_bottom_borders.position = Vector2(i*528,0)
		add_child(top_bottom_borders)
		top_bottom_borders.get_node("b_top/txt_b_top").set_texture(horizontal_source)
		top_bottom_borders.get_node("b_bottom/txt_b_bottom").set_texture(horizontal_source)
	

#func spawn_abydos_school():
#	for i in ABYDOS_STUDENTS.size():
#		spawn_player(startSpawnsQty[ABYDOS_STUDENTS.size()][i], abydosTextures[ABYDOS_STUDENTS[i]])

func spawn_custom(studentList: Array, textureList: Dictionary):
	for i in studentList.size():
		spawn_player(startSpawnsQty[studentList.size()][i], load(textureList[studentList[i]]))

func _ready():
	# Abydos
	#spawn_abydos_school()
	
	#var abydosTextures = getOneSchoolTextures(ABYDOS_STUDENTS, "abydos")
	#spawn_custom(ABYDOS_STUDENTS, abydosTextures)
	
	# Change accordingly
	var studentsList = ["Serika", "Hoshino"] #, "Shiroko", "Nonomi", "Ayane", "Hina", "Satsuki", "Iori"
	var school = "abydos"
	
	getBorders(school)
	
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
	
	# Obtener el World2D desde la raíz de la escena actual
	#print(get_tree().root.get_child(0).world_2d)
	#var world = get_tree().root.get_child(0).world_2d
	#viewport.world_2d = world
	
	#####
	#var viewport_container = $ViewportContainer
	#var viewport = $ViewportContainer/Viewport
	#var minimap_camera = $ViewportContainer/Viewport/MinimapCamera

	#$ViewportContainer/Viewport.render_target_v_flip = true
	#$ViewportContainer/Viewport.size = Vector2(400, 200)
	#minimap_camera.zoom = Vector2(0.1, 0.1)
	#minimap_camera.current = true
	#var remote_transform = RemoteTransform2D.new()
	#remote_transform.remote_path = minimap_camera.get_path()
	#add_child(remote_transform)
	#####
	
	#minimap_camera.position = get_level_center()
	#viewport.render_target_update_mode = Viewport.UPDATE_ALWAYS
	#yield(get_tree(), "idle_frame")
	#minimap_camera.position = Vector2(284,792)
	#minimap_camera.zoom = Vector2(-0.2, -0.2)  
	#texture_rect.texture = viewport.get_texture()
	#viewport.size = Vector2(1024, 512)
	

func spawn_player(position: Vector2, texture: Texture):
	var player = PLAYER_SCENE.instance()
	player.position = position
	add_child(player)
	player.set_texture(texture) # Assign texture before adding player to the scene
	player.make_trail()
	player.add_to_group("players")
	player.add_to_group("minimap_objects")
