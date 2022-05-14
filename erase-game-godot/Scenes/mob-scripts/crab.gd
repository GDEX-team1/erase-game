extends Area2D
signal hit

export var speed = 20
var screen_size


func _throw_null_error(error_value):
	print("Null Error mob-scripts.crab, %s" % error_value)


func _ready():
	screen_size = get_viewport_rect().size


func _animate_move(is_moving):
	if is_moving:
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()

func _animate_direction(velocity):
	if velocity.x < 0:
		$AnimatedSprite.flip_h = true;
	else:
		$AnimatedSprite.flip_h = false;


func _moving(delta, wall, wall_type):
	var velocity = Vector2.ZERO

	if wall != null:
		if wall_type == null:
			_throw_null_error("wall_type")
		if wall_type == "l":
			velocity.x = -1
		elif wall_type == "r":
			velocity.x = 1
		elif wall_type == "u":
			velocity.y = 1
		elif wall_type == "d":
			velocity.y = -1

	var is_moving = false

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		is_moving = true

	_animate_move(is_moving)

	_animate_direction(velocity)


	

	position += velocity * delta


func _on_crab_body_entered(body:Node):
	hide()
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true)

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false