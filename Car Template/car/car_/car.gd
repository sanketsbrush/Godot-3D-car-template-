extends VehicleBody3D

@onready var br: VehicleWheel3D = $br #back right wheel
@onready var bl: VehicleWheel3D = $bl #back left wheel

var brake_ = 5
var engine_ = 250
var steering_angle = 10

var brake_signal:int
var engine_signal:int
var steering_signal:int
var drift_signal:int
var speed:int


func _ready() -> void:
	
	center_of_mass=$"centre of mass".position
	mass=50.0
	gravity_scale=5
	linear_damp  = 0.1
	angular_damp = 0.1

func _physics_process(_delta: float) -> void:
	
	brake_signal     = int(Input.is_action_pressed("ui_accept"))
	engine_signal    = int(Input.get_axis("ui_down","ui_up"))
	steering_signal  = int(Input.get_axis("ui_right","ui_left"))
	drift_signal     = abs(engine_signal)*brake_signal*abs(steering_signal)
	speed=abs( ( (br.get_rpm()+bl.get_rpm()) /2 ) *0.84*0.1885 )
	
	brake = brake_signal * brake_
	engine_force = engine_signal * engine_
	steering = lerpf( steering , deg_to_rad(steering_signal*steering_angle) , .1 )
	if bool(drift_signal):bl.steering=lerpf(bl.steering,-steering,0.1);br.steering=bl.steering
	else:bl.steering=lerpf(bl.steering,0,0.1);br.steering=bl.steering

func _input(_event: InputEvent) -> void:
	
	if Input.is_action_just_pressed("ui_text_backspace"):
		if $crash_sensor.is_colliding():
			global_position.y+=0.5
			rotate_object_local(Vector3(0,0,1),deg_to_rad(180))
