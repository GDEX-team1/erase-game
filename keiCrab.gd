extends Area2D

signal hit

export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size #Checking the size of the screen

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
# Called every frame. 'delta' is the elapsed time since the previous frame.

	# I THINK I DON:T NEED THIS LINE? onready var _animated_sprite = $AnimatedSprite

func _process(delta):
	# Crab will walk on every frame at <speed> pixels/second
	var velocity  = Vector2.ZERO 
	velocity = velocity.normalized() * speed
	velocity.x += speed
	position += velocity * delta
	$AnimatedSprite.play("CrabWalk")
	
	# Making sure the crab doesn't move off screen
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)


func _on_Crab_body_entered(body):
	var velocity  = Vector2.ZERO 
	velocity = velocity.normalized() * speed
	velocity.x += 0
	velocity.y += 0
	$AnimatedSprite.stop()  # Crab stops upon collision
	emit_signal("hit")
	$AnimatedSprite.transform.get_rotation(60) # Crab rotates on collision
	
	### NEED TO ADD MATH TO MAKE CRAB MOVE DIAGONALLY
	velocity.x += speed
	velocity.y += speed
	position += velocity # * delta
	$AnimatedSprite.play("CrabWalk")
	
	
	# Must be deferred as we can't change physics properties on a physics callback.
	$CollisionShape2D.set_deferred("disabled", true)
