extends Node2D

var ABYDOS_STUDENTS = ["Serika", "Hoshino", "Shiroko", "Nonomi", "Ayane"]
var GEHENNA_STUDENTS = ["Makoto", "Satsuki", "Chiaki", "Iroha", "Ibuki", 
"Hina", "Ako", "Iori", "Chinatsu", "Aru", "Mutsuki", "Kayoko", "Haruka", 
"Haruna", "Junko", "Izumi", "Akari", "Fuuka", "Juri", "Sena", "Kasumi", 
"Megu", "Kirara", "Erika"]
var MILLENIUM_STUDENTS = ["Rio", "Yuuka", "Noa", "Koyuki", "Chihiro", "Maki", 
"Hare", "Kotama", "Neru", "Karin", "Akane", "Asuna", "Toki", "Hibiki", "Utaha", 
"Kotori", "Sumire", "Himari", "Eimi", "Aris", "Yuzu", "Midori", "Momoi", "Rei"]
var VALKYRIE_STUDENTS = ["Kanna", "Kirino", "Fubuki", "Konoka"]
var TRINITY_STUDENTS = ["Nagisa", "Seia", "Mika", "Kazusa", "Natsu", "Airi", 
"Yoshimi", "Reisa", "Suzumi", "Tsurugi", "Hasumi", "Mashiro", "Ichika", "Mine", 
"Hanae", "Serina", "Hifumi", "Azusa", "Koharu", "Hanako", "Ui", "Shimiko",
 "Sakurako", "Mari", "Hinata"]

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

func spawn_custom(studentList: Array, textureList: Dictionary):
	for i in studentList.size():
		spawn_player(startSpawnsQty[studentList.size()][i], load(textureList[studentList[i]]))

func _ready():
	var abydosTextures = getOneSchoolTextures(ABYDOS_STUDENTS, "abydos")
	var gehennaTextures = getOneSchoolTextures(GEHENNA_STUDENTS, "gehenna")
	var milleniumTextures = getOneSchoolTextures(MILLENIUM_STUDENTS, "millenium")
	var valkyrieTextures = getOneSchoolTextures(VALKYRIE_STUDENTS, "valkyrie")
	var trinityTextures = getOneSchoolTextures(TRINITY_STUDENTS, "trinity")
	var _allTextures = [abydosTextures, gehennaTextures, milleniumTextures, 
	valkyrieTextures, trinityTextures]
	
	# Abydos - 5
	#var school = "abydos"
	#spawn_custom(ABYDOS_STUDENTS, abydosTextures)
	
	# Gehenna - 24
#	var school = "gehenna"
#	randomize()
#	GEHENNA_STUDENTS.shuffle()
#	print(GEHENNA_STUDENTS.slice(0,7),"\n",GEHENNA_STUDENTS.slice(8,15),"\n",GEHENNA_STUDENTS.slice(16,23))
#	# write down the result
#	var studentDivision = GEHENNA_STUDENTS.slice(0,7)
#	spawn_custom(studentDivision, gehennaTextures)
	
	# Millenium - 24
#	var school = "millenium"
#	randomize()
#	MILLENIUM_STUDENTS.shuffle()
#	print(MILLENIUM_STUDENTS.slice(0,7),"\n",MILLENIUM_STUDENTS.slice(8,15),"\n",MILLENIUM_STUDENTS.slice(16,23))
#	# write down the result
#	var studentDivision = MILLENIUM_STUDENTS.slice(0,7)
#	spawn_custom(studentDivision, milleniumTextures)
	
	# Valkyrie - 4
#	var school = "valkyrie"
#	spawn_custom(VALKYRIE_STUDENTS, valkyrieTextures)
	
	# Trinity - 25
	var school = "trinity"
	randomize()
	TRINITY_STUDENTS.shuffle()
	print(TRINITY_STUDENTS.slice(0,7),"\n",TRINITY_STUDENTS.slice(8,15),"\n",TRINITY_STUDENTS.slice(16,24))
	# write down the result
	var studentDivision = TRINITY_STUDENTS.slice(0,7)
	spawn_custom(studentDivision, trinityTextures)
	
	
	##### only for custom cross-school races or 2nd semifinals (ctrl-K) #####
	
#	# Change accordingly
#	var studentsList = ["Serika", "Hoshino", "Shiroko", "Nonomi", "Ayane", "Hina", "Satsuki", "Iori"]
#	var school = "abydos" # Can be empty if cross-school ""
#
#	# Generic
#	var textures = getTextures(studentsList, _allTextures)
#	spawn_custom(studentsList, textures)
	
	##### only for custom cross-school races or 2nd semifinals (ctrl-K) #####
	
	
	Global.school = school
	getBorders(school)
	
	var position = get_tree().get_nodes_in_group("players").size()
	# Load coresponding starter platforms depending on "players" group size
	var platforms = load(startPlatforms[position]).instance()
	add_child(platforms)
	

func spawn_player(position: Vector2, texture: Texture):
	var player = PLAYER_SCENE.instance()
	player.position = position
	add_child(player)
	player.set_texture(texture) # Assign texture before adding player to the scene
	player.make_trail()
	player.add_to_group("players")
	player.add_to_group("minimap_objects")
