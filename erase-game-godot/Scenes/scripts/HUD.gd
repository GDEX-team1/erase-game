extends CanvasLayer

signal start_game
export (int) var roundTime = 180
export (int) var countDownTime = 5 #

var timeRemaining
var timer_has_played = false
var game_over_has_played = false
var isPaused = false
#position of the play of the timer sound
var timerpos

func _ready():
	$RoundTimer/Timer.wait_time = countDownTime
	

func _process(delta):
		
	timeRemaining = int($RoundTimer/Timer.time_left)
	$RoundTimer.set_text(str(timeRemaining))
	
	if timeRemaining <= countDownTime:
		#insert time nearly over sounds
		#prevents timer sound from looping
		if !timer_has_played:
			$RoundTimer/timerLowSfx.play()
			var timerpos = $RoundTimer/timerLowSfx.get_playback_position( )
			timer_has_played = true
		pass
	

func _on_Timer_timeout():
	# Insert "Game Over" display
	if !game_over_has_played:
		$RoundTimer/gameOverSfx.play()
		$RoundTimer/timerLowSFX.stop()
	pass
	

func _on_PauseButton_pressed():
	isPaused = !isPaused
	if isPaused==false:
		$RoundTimer/timerLowSFX.stop()
	if isPaused == true:
		$RoundTimer/timerLowSfx.play()
		$RoundTimer/timerLowSfx.seek(timerpos)
	
	pass # Replace with function body.
