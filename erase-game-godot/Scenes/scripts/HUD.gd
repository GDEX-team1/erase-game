extends CanvasLayer

signal start_game
signal game_paused(paused)

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
	
		
	# Insert "Game Over" display
	if timeRemaining < 0 + delta:
		emit_signal("game_over")
		game_over()
		
	var nodeSandDollar = get_node("/root/kei-main/YSort/spawnerSandDollar")
	self.connect("SandDollar_PickedUp", nodeSandDollar, "on_SandDollar_PickedUp")
		
		
# Game Over function
func game_over():
	if !game_over_has_played:
		$RoundTimer/timerLowSfx.stop()
		$RoundTimer/gameOverSfx.play()
		game_over_has_played = true
		#Switch Scenes to Game Over Screen
		
		timeRemaining = 0
	

func _on_globalTimer_timeout():
	
	if !game_over_has_played:
		if !isPaused:
			timeRemaining -= 1
			
	


func _on_PauseButton_pressed():
	print("pause button press")
	
	if !isPaused:
		isPaused = true
		
		if timer_has_played:
			$RoundTimer/timerLowSfx.stop()
		
		#$PauseButton/PauseScreen.visible = isPaused
		#emit_signal("game_paused", isPaused)
		print("Paused")
		
	else:
		isPaused = false
		
		if timer_has_played:
			$RoundTimer/timerLowSfx.seek(timerpos)
			$RoundTimer/timerLowSfx.play()
		
		#$PauseButton/PauseScreen.visible = isPaused
			
		#emit_signal("game_paused", isPaused)
		print("unpaused")
	



func _on_Bucket_Crab_entered_bucket():
	countCrab += 1

func _on_Lemon_PickedUp():
	countLemon += 1
	
func _on_SandDollar_PickedUp():
	countSandDollar += 1


func _on_PauseButton_toggled(button_pressed):
	pass # Replace with function body.
