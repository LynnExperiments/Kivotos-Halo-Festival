extends MarginContainer

export (NodePath) var player
export var zoom = 1.5

onready var grid = $MarginContainer/Grid
onready var player_marker = $MarginContainer/Grid/PlayerMarker
onready var mob_marker = $MarginContainer/Grid/MobMarker
onready var alert_marker = $MarginContainer/Grid/AlertMarker

var grid_scale
var markers = {}

func _set_player_marker_position():
	print(grid)
	player_marker.position = grid.rect_size / 2
	grid_scale = grid.rect_size / (get_viewport_rect().size * zoom)

func _ready():
	yield(get_tree(), "idle_frame")
	call_deferred("_set_player_marker_position")
	
	var map_objects = get_tree().get_nodes_in_group("minimap_objects")
	for item in map_objects:
		print(item)
		var new_marker = mob_marker.duplicate()
		grid.add_child(new_marker)
		new_marker.show()
		markers[item] = new_marker

func _process(delta):
	if !player:
		return
	player_marker.rotation = get_node(player).rotation + PI/2
	for item in markers:
		var obj_pos = (item.position - get_node(player).position) * grid_scale + grid.rect_size / 2
		markers[item].position = obj_pos
		obj_pos.x = clamp(obj_pos.x, 0, grid.rect_size.x)
		obj_pos.y = clamp(obj_pos.y, 0, grid.rect_size.y)
		if grid.get_rect().has_point(obj_pos + grid.rect_position):
			markers[item].hide()
		else:
			markers[item].show()
