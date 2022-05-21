extends Area2D

var pickedUp = false

signal SandDollar_PickedUp



# Called when the node enters the scene tree for the first time.
func _process(delta):
	$PickUpSprite.play()
	
	if pickedUp: 
		$PickUpVFX.show()
		$PickUpVFX.play("PickedUpVFX")
		$PickUpSprite.hide()
	if pickedUp == false:
		$PickUpVFX.hide()	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Lemon_body_entered(body):
	pickedUp = true
	emit_signal("Lemon_PickedUp")
	print("Lemon picked up: ", pickedUp)

func _on_Lemon_body_exited(body):
	pickedUp = false



func _on_SandDollar_body_entered(body):
	pickedUp = true
	emit_signal("SandDollar_PickedUp")
	print("SD picked up: ", pickedUp)
	
func _on_SandDollar_body_exited(body):
	pickedUp = false	
