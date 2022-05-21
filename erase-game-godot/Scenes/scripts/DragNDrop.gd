extends Area2D


var max_Sand_Meter_Frames = 5.0  #Max number of animated frames for Sand Meter, would be nice if I can automate this
export (int) var HP_Sand_Meter = 2.0 #HP per Sand Meter Frame
export (int) var HP_Sand_Dollar = 3.0 #HP the Sand Dollars replenish for the Sand Meter
var currentMeterHP
var maxMeterHP
var wallSelected



# Called when the node enters the scene tree for the first time.
func _ready():
	wallSelected = false
	maxMeterHP = max_Sand_Meter_Frames * HP_Sand_Meter
	currentMeterHP = maxMeterHP
	$SandDollar.connect("SandDollar_PickedUp",self,"pickedUp_SandDollar")
	
	



func pickedUp_SandDollar():
	
	currentMeterHP += HP_Sand_Dollar
	print("HP: ", currentMeterHP,"/",maxMeterHP)
	$sandMeterRefil.play()
	
func _physics_process(delta):
	if wallSelected:
		$Wall.position = get_global_mouse_position()
		$Wall.show() #need to make it so infinite walls can be spawned
	
	#if connect("SandDollar_PickedUp",self,"_physics_process"):
	#	currentMeterHP += HP_Sand_Dollar
	
	currentMeterHP = clamp(currentMeterHP,0,maxMeterHP)
	updateMeterSprite()
		
		
func _on_Area2D_input_event(viewport, event, shape_idx):
	
	if Input.is_action_just_pressed("ui_leftclick") and not wallSelected:
		wallSelected=true
		currentMeterHP -= 1
		$sandMeterDeplete.play()
	
func _input(event):
	if Input.is_action_just_pressed("ui_rightclick") and wallSelected:
		wallSelected = false
		currentMeterHP +=1
	## Code used for manually adjusting Sand Meter HP
	if Input.is_action_just_pressed("ui_up"):
		currentMeterHP +=1
		print("HP: ", currentMeterHP,"/",maxMeterHP)
		$sandMeterRefil.play()
	if Input.is_action_just_pressed("ui_down"):
		currentMeterHP -=1
		print("HP: ", currentMeterHP,"/",maxMeterHP)
		$sandMeterDeplete.play()
	
	
func updateMeterSprite():
	
	# Using a variable to make the math/code slightly easier to understand
	var f = floor(currentMeterHP / HP_Sand_Meter)

	#Changing the frames of the sprite based on the current HP of the Sand Meter
	# SandMeter_Main will always be 1 frame below of the silhouette
	# SandMeter_Silhouette HP is the remainder of (CurrentHP / # HP per frames of the sand wall)
	# The remainer is used as a % to change the opacity of SM_Silhouette
	$SandMeter_Main.frame = clamp(f-1 , 0 , maxMeterHP / HP_Sand_Meter)
	$SandMeter_Silhouette.frame = clamp(f , 0 , maxMeterHP / HP_Sand_Meter)
	$SandMeter_Silhouette.modulate.a = float((currentMeterHP / HP_Sand_Meter) - f)
		
