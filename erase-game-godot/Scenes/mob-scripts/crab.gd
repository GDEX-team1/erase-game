extends KinematicBody2D

export(int) var speed = 40
export(float) var rotation_speed = 1.5
var screen_size
var velocity = Vector2()
var isPaused = false


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
	
	#var nodeHUD = get_node("/root/kei-main/HUD/")
	#nodeHUD.connect("game_paused", self, "_on_HUD_game_paused")
	
	if !isPaused:
		var rotation_dir = move_and_slide(velocity * speed).angle()  # Get Crab collision angle & Move crab forward

		velocity = Vector2(speed, 0).rotated(rotation_dir)  # Crab moves parallel to the obstacle
		velocity = velocity.normalized() * speed * delta

		_animate_move(true)
	else:
		_animate_move(false)
	

func _on_HUD_game_paused(paused):
	
	isPaused = paused
