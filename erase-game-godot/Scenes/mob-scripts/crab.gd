extends Area2D
signal hit

export (int) var speed = 40
export (float) var rotation_speed = 1.5
var screen_size
var velocity = Vector2()
var rotation_dir = 0


func _throw_null_error(error_value):
	print("Null Error mob-scripts.crab, %s" % error_value)


func _ready():
	screen_size = get_viewport_rect().size


func _animate_move(is_moving):
	if is_moving:
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()

## Crab doesn't turn back after hitting a wall
#func _animate_direction(velocity):
#	if velocity.x < 0:
#		$AnimatedSprite.flip_h = true;
#	else:
#		$AnimatedSprite.flip_h = false;



func get_input():
	
	# Temporary turning movement input controls
	rotation_dir = 0
	
	if Input.is_action_pressed("ui_right"):
		rotation_dir += 1
	if Input.is_action_pressed("ui_left"):
		rotation_dir -= 1


	
	
func _process(delta):
	# Crab will move forward on every frame at <speed> pixels/second
	
	get_input()
	rotation += rotation_dir * rotation_speed * delta
	
	
	velocity = velocity.normalized() * speed 
	velocity = Vector2(speed, 0).rotated(rotation) # Sets the crab's direction
	position += velocity * delta  # Moves the crab in the direction
	_animate_move(true)
#	
	## Making sure the crab doesn't move off screen
	# position.x = clamp(position.x, 0, screen_size.x)
	# position.y = clamp(position.y, 0, screen_size.y)

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


func _on_crab_body_entered(body:Node):
	hide()
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true)

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
