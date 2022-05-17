extends Area2D
signal hit

export var speed = 20
var anim_sprite = false
var screen_size
var wall
var wall_type


func _throw_null_error(error_value):
	print("Null Error mob-scripts.crab, %s" % error_value)


func _ready():
	screen_size = get_viewport_rect().size


func _animate_move(is_moving) -> bool:
	if is_moving:
		return true

	return false


func _animate_direction(velocity) -> bool:
	if velocity.x < 0:
		return true

	return false


func _process(delta: float):
	var velocity = Vector2(20,0)
	$AnimatedSprite.playing = true

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
