extends Control
signal button_pressed	
	

func _on_Play_pressed() -> void:
	$AudioStreamPlayer.stop()
	emit_signal("button_pressed")
