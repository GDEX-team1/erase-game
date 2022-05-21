extends Node

var score
var screen_size
export var crab_positions: PoolVector2Array

func game_over():
	$StartTimer.stop()


func won():
	pass


func new_game():
	$spawner.crab_spawns = crab_positions
	$spawner.spawn_crab()
	$StartTimer.start()


func _ready():
	randomize()
	new_game()


func _on_StartTimer_timeout():
	$StartTimer.stop()
	$spawner.spawn_wave()
	


func _on_WaveTimer_timeout():
	game_over()


func _on_crab_hit():
	game_over()
