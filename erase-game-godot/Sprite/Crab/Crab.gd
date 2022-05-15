extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.

onready var _animated_sprite = $AnimatedSprite

func _process(_delta):
	# Crab will walk on every frame
	_animated_sprite.play("CrabWalk")
