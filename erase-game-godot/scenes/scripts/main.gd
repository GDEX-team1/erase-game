extends Node2D

export var wave_scene: PackedScene
var score

func game_over():
	$StartTimer.stop()
	$WaveTimer.stop()

func won():
	pass


func _ready():
	$StartTimer.start()
	$WaveTimer.start()


func _on_crab_hit():
	game_over()
	
### Crab Spawn Logic below
export(PackedScene) var crab_scene

