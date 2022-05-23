extends KinematicBody2D

export(int) var speed = 40
export(float) var rotation_speed = 1.5
export(float) var lemon_speedUp = 1.5 # Crab movespeed % increase when picked up lemons
export(float) var lemon_duration = 2.5 # lemon power up duration, in seconds
var screen_size
var velocity = Vector2()

var lemon_timer = 0
var lemon_active = false

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
	#var _rl =  SignalBus.connect("Lemon_PickedUp", self, "_on_Lemon_PickedUp")

		
	var rotation_dir = move_and_slide(velocity * speed).angle()  # Get Crab collision angle & Move crab forward

	velocity = Vector2(speed, 0).rotated(rotation_dir)  # Crab moves parallel to the obstacle
	velocity = velocity.normalized() * speed * delta

	_animate_move(true)
	
func _on_Lemon_PickedUp():
		lemon_active = true
		
		
