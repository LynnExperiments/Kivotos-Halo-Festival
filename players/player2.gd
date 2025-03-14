extends RigidBody2D

onready var raycast_holder = $raycast_holder
onready var raycast = $raycast_holder/RayCast2D
onready var sprite = $spr_player2
var trail: Line2D
var is_jumping = false

var rng = RandomNumberGenerator.new()
var jump_force = Vector2(0, 0)
var wait_time = 0.0
var average_color = Color(1, 1, 1, 1)

func _ready():
	raycast.enabled = true
	average_color = get_average_color(sprite.texture)
	rng.randomize()

func get_average_color(texture: Texture) -> Color:
	var image = texture.get_data()
	image.lock()

	var total_color = Color(0, 0, 0, 0)
	var pixel_count = 0

	for x in range(image.get_width()):
		for y in range(image.get_height()):
			var pixel = image.get_pixel(x, y)
			# Only consider non-invisible pixels
			if pixel.a > 0.0:
				total_color += pixel
				pixel_count += 1

	image.unlock()

	if pixel_count > 0:
		var avg_color = total_color / pixel_count
		# Keep 100% opacity
		avg_color.a = 1.0  
		return avg_color
	# White color by default
	return Color(1, 1, 1, 1) 


func set_texture(texture: Texture):
	var sprite = get_node("spr_player2")
	if sprite:
		sprite.texture = texture

func make_trail():
	trail = Line2D.new()
	trail.width = 3.0 
	average_color = get_average_color(sprite.texture)
	trail.default_color = average_color
	trail.z_index = -5
	get_parent().add_child(trail)

func get_random_number_int(min_val: int, max_val: int) -> int:
	var result = rng.randi_range(min_val, max_val)
	return result

func get_random_number_float(min_val: float, max_val: float) -> float:
	var result = rng.randf_range(min_val, max_val)
	return result

func start_jump_cycle():
	while true:
		wait_time = get_random_number_float(1.00, 3.00)
		yield(get_tree().create_timer(wait_time), "timeout")

func _process(delta):
	var trail_manager = get_parent().get_node("trail_manager") if get_parent().has_node("trail_manager") else null
	if trail_manager:
		trail_manager.add_trail_point(global_position, average_color)

func wait_and_jump():
	is_jumping = true
	wait_time = get_random_number_float(0.50, 3.00)
	yield(get_tree().create_timer(wait_time), "timeout")
	jump_force = Vector2(get_random_number_int(-50, 350),get_random_number_int(-50,-400))
	apply_impulse(Vector2.ZERO, jump_force)
	is_jumping = false

# Jump if on floor or another player
func _on_Area2D_area_entered(area):
	if is_jumping:
		return
	wait_and_jump()

# Jump if on platforms
func _on_Area2D_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if is_jumping:
		return
	if body is TileMap or body.get_parent().name == "start_platforms":
		wait_and_jump()
