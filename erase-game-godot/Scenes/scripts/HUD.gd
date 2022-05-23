extends CanvasLayer

signal game_over(pointsCrab, pointsLemon, pointsSandDollar, countCrab, countLemon, countSandDollar)


export (int) var roundTime = 180.0
export (int) var countDownTime = 5 #Time for "Time's Nearly Up SFX to start
export (int) var pointsCrab = 100
export (int) var pointsLemon = 50
export (int) var pointsSandDollar = 10
export(PackedScene) var TimeUp

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
	
	var _rsd = SignalBus.connect("SandDollar_PickedUp", self, "_on_SandDollar_PickedUp")
	var _rl =  SignalBus.connect("Lemon_PickedUp", self, "_on_Lemon_PickedUp")
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
		SignalBus.emit_signal("game_over", pointsCrab, pointsLemon, pointsSandDollar, countCrab, countLemon, countSandDollar)

		game_over()
				
# Game Over function
func game_over():
	if !game_over_has_played:
		$RoundTimer/timerLowSfx.stop()
		$RoundTimer/gameOverSfx.play()
		game_over_has_played = true
		timeRemaining = 0
		
		var rc = get_tree().change_scene("res://Scenes/main/TimeUp.tscn")
		
		#var game_over = TimeUp.instance()
		#add_child(game_over)
		
		
		#game_over.pointsCrab = pointsCrab
		#game_over.pointsLemon = pointsLemon
		#game_over.pointsSandDollar = pointsSandDollar
		#game_over.countCrab = countCrab
		#game_over.countLemon = countLemon
		#game_over.countSandDollar = countSandDollar
		
		
		
		
	

func _on_globalTimer_timeout():
	emit_signal("_on_globalTimer_timeout")
	if !game_over_has_played:
		if !isPaused:
			timeRemaining -= 1
	


func _on_PauseButton_pressed():
	
	if isPaused==false:
		
		$RoundTimer/timerLowSfx.stop()
	else:
		$RoundTimer/timerLowSfx.play()
		$RoundTimer/timerLowSfx.seek(timerpos)
	isPaused = !isPaused



func _on_Bucket_Crab_entered_bucket():
	countCrab += 1

func _on_Lemon_PickedUp():
	countLemon += 1
	
func _on_SandDollar_PickedUp():
	
	countSandDollar += 1
