extends Area2D



export (int) var HP_Sand_Meter = 2.0 #HP per Sand Meter Frame
export (int) var HP_Sand_Dollar = 3.0 #HP the Sand Dollars replenish for the Sand Meter
export (int) var speed_SandWall = 60 #Speed the SandWalls travel at
export (PackedScene) var Wall 

var max_Sand_Meter_Frames = 5.0  #Max number of animated frames for Sand Meter, would be nice if I can automate this
var currentMeterHP
var maxMeterHP
var wallSelected
var new_wall 

	

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
	
	if wallSelected == true: #and Input.is_action_just_pressed("ui_leftclick"):
		new_wall.set_position(get_local_mouse_position())	
		
	
	currentMeterHP = clamp(currentMeterHP,0,maxMeterHP)
	updateMeterSprite()
		
		
func _on_Area2D_input_event(viewport, event, shape_idx):
	
	# Selecting the wall
	if Input.is_action_just_pressed("ui_leftclick") and not wallSelected:
		new_wall = Wall.instance()
		wallSelected = true
		currentMeterHP -= 1
		$sandMeterDeplete.play()
		add_child(new_wall)
		print("Wall Picked Up")
		
			
	
func _input(event):
	# Cancel wall
	if Input.is_action_just_pressed("ui_rightclick") and wallSelected:
		wallSelected = false
		remove_child(new_wall)
		currentMeterHP +=1
	
	# Place wall
	if Input.is_action_just_pressed("ui_leftclick") and wallSelected:
		wallSelected = false
		new_wall.set_position(get_local_mouse_position())
		
		
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
	print("HP: ", currentMeterHP,"/",maxMeterHP)
		
