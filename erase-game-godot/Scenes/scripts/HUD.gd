extends CanvasLayer

signal start_game


export (int) var roundTime = 180.0
export (int) var countDownTime = 5 #Time for "Time's Nearly Up SFX to start
export (int) var pointsCrab = 100
export (int) var pointsLemon = 50
export (int) var pointsSandDollar = 10

var score = 0
var countCrab = 0
var countLemon= 0
var countSandDollar= 0




var timeRemaining
var	timer_has_played = false
var	game_over_has_played = false
var	isPaused = false



var timerpos #position of the play of the timer sound


func _ready():
	
	timeRemaining = roundTime
	

	print("export var: ",roundTime, ", getTimer:", timeRemaining)

func _process(delta):
		
	$RoundTimer.set_text(str(timeRemaining))
	score = countCrab * pointsCrab \
		+ countLemon * pointsLemon \
		+ countSandDollar * pointsSandDollar
			
	$ScoreLabel.set_text(str(score))
	
	if timeRemaining <= countDownTime:
		if !timer_has_played:
			$RoundTimer/timerLowSfx.play()
			timer_has_played = true
			$RoundTimer.modulate = Color.brown
		timerpos = $RoundTimer/timerLowSfx.get_playback_position( )
		print(delta)
		
	# Insert "Game Over" display
	if timeRemaining < 0 + delta:
		emit_signal("game_over")
		game_over()
		
		
		
		
# Game Over function
func game_over():
	if !game_over_has_played:
		$RoundTimer/timerLowSfx.stop()
		$RoundTimer/gameOverSfx.play()
		game_over_has_played = true
		timeRemaining = 0
	

func _on_globalTimer_timeout():
	emit_signal("_on_globalTimer_timeout")
	if !game_over_has_played:
		if !isPaused:
			timeRemaining -= 1
	


func _on_PauseButton_pressed():
	
	if isPaused==false:
		
		$RoundTimer/timerLowSfx.stop()
	else:
		print("Paused: ", timerpos)
		$RoundTimer/timerLowSfx.play()
		$RoundTimer/timerLowSfx.seek(timerpos)
	isPaused = !isPaused



func _on_Bucket_Crab_entered_bucket():
	countCrab += 1

func _on_SandDollar2_Lemon_PickedUp():
	countLemon += 1

func _on_SandDollar2_SandDollar_PickedUp():
	countSandDollar += 1
