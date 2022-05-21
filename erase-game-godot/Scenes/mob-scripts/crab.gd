extends KinematicBody2D

export(int) var speed = 40
export(float) var rotation_speed = 1.5
var screen_size
var velocity = Vector2()


func _throw_null_error(error_value):
	print("Null Error mob-scripts.crab, %s" % error_value)


func _ready():
	screen_size = get_viewport_rect().size


func _animate_move(is_moving):
	if is_moving:
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()


func _physics_process(delta):
	var rotation_dir = move_and_slide(velocity * speed).angle()  # Get Crab collision angle & Move crab forward

	velocity = Vector2(speed, 0).rotated(rotation_dir)  # Crab moves parallel to the obstacle
	velocity = velocity.normalized() * speed * delta

	_animate_move(true)
