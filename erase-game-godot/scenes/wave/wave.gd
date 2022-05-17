extends RigidBody2D

export var speed = 20

func _ready():
	$AnimatedSprite.play()
	var wave_types = $AnimatedSprite.frames.get_animation_names()
	$AnimatedSprite.animation = wave_types[randi() % wave_types.size()]


func _moving():
	var velocity = Vector2(0,1)

	position += velocity * speed

