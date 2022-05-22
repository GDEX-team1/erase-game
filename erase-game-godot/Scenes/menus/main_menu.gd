extends Control
signal button_pressed

func _on_Button_pressed():
	$AudioStreamPlayer.stop()
	emit_signal("button_pressed")