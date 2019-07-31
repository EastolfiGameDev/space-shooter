extends RigidBody2D

const SPEED = 200
const ROTATION_SPEED = 80
const MAX_SPEED = 150

func _ready():
	pass

func _process(delta):
	if Input.is_action_pressed("ui_up"):
		add_force(Vector2.ZERO, Vector2(cos(rotation), sin(rotation)) * delta * SPEED)
	
	if get_linear_velocity().length() > MAX_SPEED:
		set_linear_velocity(get_linear_velocity().normalized() * MAX_SPEED)
	
	if Input.is_action_pressed("ui_left"):
		set_angular_velocity(-ROTATION_SPEED * delta)
	if Input.is_action_pressed("ui_right"):
		set_angular_velocity(ROTATION_SPEED * delta)