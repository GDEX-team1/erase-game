extends Node

# Mass spawn variables
export var mass_spawn: bool
export var spawn_base: Vector2
export var spawn_end: int
export var spawn_offset: int
export var direction_y = false

# Individual spawn variables
export var spawn_locations: PoolVector2Array

export(PackedScene) var object


func start():
	if mass_spawn:
		_mass_spawn()

	else:
		_individual_spawn()


func _range_spawn(start, stop):
	for pos in range(start, stop, spawn_offset):
		var object_scene = object.instance()
		object_scene.position = spawn_base
		if direction_y:
			object_scene.position.y = pos
		else:
			object_scene.position.x = pos
		add_child(object_scene)


func _mass_spawn():

	if direction_y:
		_range_spawn(spawn_base.y, spawn_end)
	else:
		_range_spawn(spawn_base.x, spawn_end)

func _individual_spawn():
	for pos in spawn_locations:
		var object_scene = object.instance()
		object_scene.position = pos
		add_child(object_scene)
