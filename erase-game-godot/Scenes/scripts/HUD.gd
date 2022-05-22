extends CanvasLayer

signal start_game
export (int) var roundTime = 180
export (int) var countDownTime = 5 #

var timeRemaining

func _ready():
	$RoundTimer/Timer.wait_time = countDownTime
	

func _process(delta):
		
	timeRemaining = int($RoundTimer/Timer.time_left)
	$RoundTimer.set_text(str(timeRemaining))
	
	if timeRemaining <= countDownTime:
		#insert time nearly over sounds
		pass
	

func _on_Timer_timeout():
	# Insert "Game Over" display
	pass

func _on_PauseButton_pressed():
	pass # Replace with function body.
