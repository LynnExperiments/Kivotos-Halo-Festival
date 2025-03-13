extends Node2D

var trail_texture: ImageTexture
var trail_image: Image

func _ready():
	# Create empty image
	trail_image = Image.new()
	trail_image.create(2028, 1200, false, Image.FORMAT_RGBA8)
	trail_image.fill(Color(0, 0, 0, 0))  # Transparent background

	trail_texture = ImageTexture.new()
	trail_texture.create_from_image(trail_image)

func add_trail_point(pos, color):
	var x = int(pos.x)
	var y = int(pos.y)

	trail_image.lock()

	# Draw pixel on current position
	for dx in range(-2, 0):
		for dy in range(-2, 0):
			if x + dx >= 0 and x + dx < 2028 and y + dy >= 0 and y + dy < 1200:
				trail_image.set_pixel(x + dx, y + dy, color)

	trail_image.unlock()

	# Update texture
	trail_texture.set_data(trail_image)
	update()

func _draw():
	draw_texture(trail_texture, Vector2.ZERO)
