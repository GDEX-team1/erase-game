extends Node

export var crab_spawns: PoolVector2Array

func spawn_crab():
	for pos in crab_spawns:
		var crab = load('res://scenes/crab/crab.tscn')
		var crab_scene = crab.instance()
		crab_scene.position = pos
		add_child(crab_scene)

func spawn_wave():
	var pos = Vector2(0, 800)
	for pos_x in range(0, 1000, 55):
		var wave = load("res://scenes/wave/wave.tscn")
		var wave_scene = wave.instance()
		pos.x = pos_x
		wave_scene.position = pos
		add_child(wave_scene)


