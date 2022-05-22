extends Area2D

var pickedUp = false

signal SandDollar_PickedUp
signal Lemon_PickedUp

var delay =0
var max_delay = 1.5 #time (in seconds) needed for VFX to play & pick up hit box to be disabled


func _process(delta):
	$PickUpSprite.play()

	if pickedUp:
		$PickUpVFX.show()
		$PickUpVFX.play("PickedUpVFX")
		$PickUpSprite.hide()
		delay += delta
		

	if delay > max_delay:
		$PickUpVFX.hide()
		$CollisionShape2D.disabled = true
		pickedUp = false
		


func _on_Lemon_body_entered(_body):
	pickedUp = true
	emit_signal("Lemon_PickedUp")
	$pickedUpSfx.play()
	print("Lemon picked up: ", pickedUp)


func _on_SandDollar_body_entered(_body):
	pickedUp = true
	emit_signal("SandDollar_PickedUp")
	print("SD picked up: ", pickedUp)
	$pickedUpSfx.play()

