extends GutTest

var crab = load('res://scenes/crab/crab.gd')

var _crab = null

func before_each():
	_crab = crab.new()




func test_animate_move_flips() -> void:
	var rc = _crab._animate_direction(Vector2(-1,0))

	assert_true(rc)

func test_animate_move_does_not_flips() -> void:
	var rc = _crab._animate_direction(Vector2(1,0))

	assert_false(rc)


func after_each():
	_crab.free()
