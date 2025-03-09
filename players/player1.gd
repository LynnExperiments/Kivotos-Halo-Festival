extends KinematicBody2D

const GRAVITY = 9.81
const MASS = 0.8
const SPEED = 200.0

var move = Vector2.ZERO
var move_dir = 1

func _ready():
	pass

func _physics_process(delta):
	apply_gravity(delta)
	handle_move(delta)
	move_and_slide(move)

func apply_gravity(delta):
	move.y += MASS * GRAVITY

func handle_move(delta):
	move.x = move_dir + SPEED
