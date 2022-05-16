# GdUnit generated TestSuite
#warning-ignore-all:unused_argument
#warning-ignore-all:return_value_discarded
class_name CrabTest
extends GdUnitTestSuite

# TestSuite generated from
const __source = 'res://scenes/crab/crab.gd'
var crab
var anim_sprite

func before():
	crab = load(__source).new()

func before_test():
	anim_sprite = mock(AnimatedSprite)

func test__animate_direction_image_flipped():

	crab.AnimatedSprite = anim_sprite
	var rc = crab._animate_direction(-1)
	assert_bool(rc).is_true()

func test__animate_direction_image_not_flipped():

	crab.AnimatedSprite = anim_sprite
	var rc = crab._animate_direction(1)
	assert_bool(rc).is_false()

func after_test():
	anim_sprite.free()

func after():
	crab.free()
