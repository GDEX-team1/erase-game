extends Node

var score
var screen_size

func game_over():
	$StartTimer.stop()

func won():
	pass

func new_game():
	$crab.start($CrabStart.position)
	$StartTimer.start()

func _ready():
	new_game()


func _on_StartTimer_timeout():
	$StartTimer.stop()
	var pos = Vector2(0,850)
	for pos_x in range(0, 1000, 55):
		var wave = load ('res://scenes/wave/wave.tscn')
		var wave_scene = wave.instance()
		pos.x = pos_x
		wave_scene.position = pos
		add_child(wave_scene)

func _on_WaveTimer_timeout():
	game_over()

func _on_crab_hit():
	game_over()
