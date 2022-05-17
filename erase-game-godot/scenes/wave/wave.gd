extends RigidBody2D

export var speed = 20

func _process(delta):
	var velocity = Vector2(0,-speed)

	position += velocity*delta

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
