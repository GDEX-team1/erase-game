extends Node




func _on_mainmenu_button_pressed() -> void:
	var rc = get_tree().change_scene("res://Scenes/main/kei-main.tscn")

	print(rc)
