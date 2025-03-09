extends RigidBody2D

onready var raycast = $RayCast2D
var trail: Line2D
onready var sprite = $spr_player2

var rng = RandomNumberGenerator.new()
var jump_force = Vector2(0, 0)
var wait_time = 0.0
var average_color = Color(1, 1, 1, 1)

func _ready():
	raycast.enabled = true
	rng.randomize()
	start_jump_cycle()
	
func get_average_color(texture: Texture) -> Color:
	var image = texture.get_data()
	image.lock()

	var total_color = Color(0, 0, 0, 0)
	var pixel_count = 0

	for x in range(image.get_width()):
		for y in range(image.get_height()):
			total_color += image.get_pixel(x, y)
			pixel_count += 1

	image.unlock()

	if pixel_count > 0:
		return total_color / pixel_count
	return Color(1, 1, 1, 1)
	
	
func set_texture(texture: Texture):
#	sprite.texture = texture
	var sprite = get_node("spr_player2")
	if sprite:
		sprite.texture = texture

func make_trail():
	trail = Line2D.new()
	trail.width = 5.0 
	average_color = get_average_color(sprite.texture)
	trail.default_color = average_color
	trail.z_index = -5
	get_parent().add_child(trail)

func get_random_number_int(min_val: int, max_val: int) -> int:
	var result = rng.randi_range(min_val, max_val)
	print(result)
	return result
	
func get_random_number_float(min_val: float, max_val: float) -> float:
	var result = rng.randf_range(min_val, max_val)
	return result

func start_jump_cycle():
	while true:
		 # Espera 1 segundo
		wait_time = get_random_number_float(0.01, 3.00)
		yield(get_tree().create_timer(wait_time), "timeout")
		 # Solo salta si está tocando el suelo
		if raycast.is_colliding(): 
			jump_force = Vector2(get_random_number_int(-50, 350),get_random_number_int(-10,-400))
			apply_impulse(Vector2.ZERO, jump_force)

func _process(delta):
	add_trail_point()

func add_trail_point():
	if trail:
		trail.add_point(global_position)
