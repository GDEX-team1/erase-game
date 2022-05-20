extends RigidBody2D

export var base_speed = 10.0
var variation = 0

func _process(delta):
	var velocity = Vector2(0, -1)


	if fmod(delta,0.5) == 0:
		variation = (50 + randi() % 100)


	var speed = base_speed + variation

	position += velocity * delta * speed


func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
