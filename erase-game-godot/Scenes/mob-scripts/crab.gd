extends KinematicBody2D
signal hit

export (int) var speed = 40
export (float) var rotation_speed = 1.5
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
	

	var rotation_dir_i = abs(move_and_slide(velocity * 60).angle())
	var rotation_dir_j = abs(move_and_slide(velocity * 60).angle())
		
	print("1:", rotation_dir_i)
	move_and_slide(velocity * 60)
	
	rotation_dir_i = abs(move_and_slide(velocity * 60).angle())
	print("2:",rotation_dir_i)

	# Checks if the travel angle on the current frame is the same as previous
	# If so, go in a straight line
	# If not, rotate a bit to visually show a slide
	if rotation_dir_i == rotation_dir_j:
		velocity = Vector2(speed, 0).rotated(rotation)
		velocity = velocity.normalized() * speed * delta
	else:
		rotation += rotation_dir_j * rotation_speed * delta
		## Need to add visual protection where crab rotates more than 180 degree

	_animate_move(true)
#	
	## If needed, use this code so the crab doesn't move off screen
	#position.x = clamp(position.x, 0, screen_size.x)
	#position.y = clamp(position.y, 0, screen_size.y)

## Not sure how this chunk of code will work
# func _moving(delta, wall, wall_type):
	
#	if wall != null:
#		if wall_type == null:
#			_throw_null_error("wall_type")
#		if wall_type == "l":
#			velocity.x = -1
#		elif wall_type == "r":
#			velocity.x = 1
#		elif wall_type == "u":
#			velocity.y = 1
#		elif wall_type == "d":
#			velocity.y = -1

#	var is_moving = false

#	if velocity.length() > 0:
#		velocity = velocity.normalized() * speed
#		is_moving = true

#	_animate_move(is_moving)

#	_animate_direction(velocity)

#	position += velocity * delta


## Crab Collision Code
#func _on_crab_body_entered(body:Node):
	#print("I'm hit")
	#emit_signal("hit")
	#$CollisionShape2D.set_deferred("disabled", true)

#func start(pos):
#	position = pos
#	show()
#	$CollisionShape2D.disabled = false
	
#func _on_VisibilityNotifier2D_screen_exited():
#	queue_free()
