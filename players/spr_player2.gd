extends Sprite

var trail: Line2D  # Referencia al nodo de la línea

func _ready():
	# Crear un nuevo Line2D y agregarlo a la escena principal
	trail = Line2D.new()
	trail.width = 5.0  # Grosor del rastro
	trail.default_color = Color(1, 1, 1, 1)  # Color blanco
	get_parent().add_child(trail)  # Asegurar que no sea hijo del personaje

func add_trail_point():
	if trail:
		trail.add_point(get_parent().global_position)  # Usar coordenadas globales

		# Limitar la cantidad de puntos en la línea para optimizar rendimiento
		if trail.get_point_count() > 100:
			trail.remove_point(0)
