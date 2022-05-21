extends Node

var score
var screen_size

func game_over():
	$StartTimer.stop()


func won():
	pass


func new_game():
	$CrabSpawner.start()
	$WaveSpawner.start()
	$BucketSpawner.start()

func _ready():
	randomize()
	new_game()





func _on_crab_hit():
	game_over()
