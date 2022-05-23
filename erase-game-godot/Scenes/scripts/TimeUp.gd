extends Node

var pointsCrab = 0
var pointsLemon = 0
var pointsSandDollar = 0
var countCrab = 0
var countLemon = 0
var countSandDollar = 0
var score= 0

func _ready():
	
	
	var _rc = SignalBus.connect("game_over", self, "_on_HUD_game_over")
	
func _on_HUD_game_over():
	$Crab/countCrab.set_text(str(countCrab))
	$Lemon/countLemon.set_text(str(countLemon))
	$SandDollar/countSandDollar.set_text(str(countSandDollar))

	score = countCrab * pointsCrab \
	+ countLemon * pointsLemon \
	+ countSandDollar * pointsSandDollar
	
	pointsCrab = pointsCrab * countCrab
	pointsLemon = pointsLemon * countLemon
	pointsSandDollar = pointsSandDollar * countSandDollar
	
	
	$Crab/pointsCrab.set_text(str(pointsCrab))
	$Lemon/pointsLemon.set_text(str(pointsLemon))
	$SandDollar/pointsSandDollar.set_text(str(pointsSandDollar))
		
		
	
	


func _on_Button_pressed():
	var rc = get_tree().change_scene("res://Scenes/main/kei-main.tscn")
