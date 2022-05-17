extends Node

var score

func game_over():
	$StartTimer.stop()
	$WaveTimer.stop()

func won():
	pass

func new_game():
	$crab.start($CrabStart.position)
	$wave.start($WaveStart.position)
	$StartTimer.start()

func _ready():
	new_game()

func _on_StartTimer_timeout():
	$WaveTimer.start()
	$wave.start($WaveStart.position)

func _on_WaveTimer_timeout():
	game_over()

func _on_crab_hit():
	game_over()
