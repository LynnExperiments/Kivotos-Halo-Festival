extends Node2D

var trail_texture: ImageTexture
var trail_image: Image

func _ready():
	# Crear una imagen vacía del tamaño de la pantalla
	trail_image = Image.new()
	trail_image.create(2028, 1200, false, Image.FORMAT_RGBA8)
	trail_image.fill(Color(0, 0, 0, 0))  # Fondo transparente

	trail_texture = ImageTexture.new()
	trail_texture.create_from_image(trail_image)

func add_trail_point(pos, color):
	# Convertir la posición global a coordenadas de la imagen
	var x = int(pos.x)
	var y = int(pos.y)

	# Bloquear la imagen para permitir modificaciones
	trail_image.lock()

	# Dibujar un pequeño punto en la imagen
	for dx in range(-2, 0):
		for dy in range(-2, 0):
			if x + dx >= 0 and x + dx < 2028 and y + dy >= 0 and y + dy < 1200:
				trail_image.set_pixel(x + dx, y + dy, color)

	# Desbloquear la imagen después de modificarla
	trail_image.unlock()

	# Actualizar la textura con la imagen modificada
	trail_texture.set_data(trail_image)
	update()

func _draw():
	# Dibujar la textura con el trail permanente
	draw_texture(trail_texture, Vector2.ZERO)
