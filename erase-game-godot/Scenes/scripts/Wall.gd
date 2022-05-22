extends StaticBody2D

var wallFrame: int
var wallDropped = false


func ready():
	wallFrame = 0


func _physics_process(_delta):
	#wallFrame = $AnimatedSprite.frame
	pass


func _input(_event):
	var wallFlip: bool
	var wallCollision: float
	var wallOffset = Vector2.ZERO

	if Input.is_action_just_pressed("ui_left"):
		wallFrame -= 1
	if Input.is_action_pressed("ui_right"):
		wallFrame += 1

	# Call the wall's sprite based on the user's input
	if !wallDropped:
		match wallFrame:
			-1:
				wallFrame = 8
				wallFlip = true
				wallCollision = -110
				wallOffset = Vector2(10, -3)

			0:
				wallFlip = false
				wallCollision = 90
				wallOffset = Vector2(0, 0)

			1:
				wallFlip = false
				wallCollision = 110
				wallOffset = Vector2(-10, -3)

			2:
				wallFlip = false
				wallCollision = 125
				wallOffset = Vector2(4, 4)

			3:
				wallFlip = false
				wallCollision = 140
				wallOffset = Vector2(3, 1)

			4:
				wallFlip = false
				wallCollision = 155
				wallOffset = Vector2(17, 6)

			5:
				wallFlip = true
				wallCollision = -155
				wallOffset = Vector2(-17, 6)

			6:
				wallFlip = true
				wallCollision = -140
				wallOffset = Vector2(-3, 1)
			7:
				wallFlip = true
				wallCollision = -125
				wallOffset = Vector2(-4, 4)

			8:
				wallFlip = true
				wallCollision = -110
				wallOffset = Vector2(10, -3)

			9:
				wallFrame = 0
				wallFlip = false
				wallCollision = 90
				wallOffset = Vector2(0, 0)

		$AnimatedSprite.set_frame(wallFrame)
		$AnimatedSprite.flip_h = wallFlip
		$AnimatedSprite.position = wallOffset
		$CollisionShape2D.rotation_degrees = wallCollision
