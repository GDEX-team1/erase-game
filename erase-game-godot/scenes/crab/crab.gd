extends Area2D
signal hit

export var speed = 20
var anim_sprite = false
var screen_size


func _throw_null_error(error_value):
	print("Null Error mob-scripts.crab, %s" % error_value)


func _ready():
	screen_size = get_viewport_rect().size


func _animate_move(is_moving):
	if is_moving:
		anim_sprite = true
		$AnimatedSprite.play()
	else:
		anim_sprite = false
		$AnimatedSprite.stop()


func _animate_direction(velocity) -> bool:
	if velocity.x < 0:
		return true

	return false

func _moving(delta, wall, wall_type):
	var velocity = Vector2.ZERO

	if wall != null:
		match wall_type:
			null:
				_throw_null_error("wall_type")
			"l", "ul", "dl":
				velocity.x = -1
			"r", "ur", "dr":
				velocity.x = 1
			"u", "ur", "ul":
				velocity.y = 1
			"d", "dr", "dl":
				velocity.y = -1

	$AnimatedSprite.flip_h = _animate_direction(velocity)

	_animate_direction(velocity)

	position += velocity * delta


func _on_crab_body_entered(body: Node):
	hide()
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true)


func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
