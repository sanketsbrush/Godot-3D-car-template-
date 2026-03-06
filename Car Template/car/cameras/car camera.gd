extends Camera3D

@onready var car: RigidBody3D = $".."

func  _ready() -> void:
	top_level=true

func _physics_process(_delta: float) -> void:
	
	var carpos=car.global_position+Vector3(0.,2.,0.)
	var dist:float= self.global_position.distance_to(carpos)
	var cam_dist=abs(dist-5.0)*float(dist>5)*.1
	
	global_position.y=lerpf(global_position.y,carpos.y,0.5)
	global_position.x=lerpf(global_position.x,carpos.x,cam_dist)
	global_position.z=lerpf(global_position.z,carpos.z,cam_dist)
	look_at(car.global_position)

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_focus_next"):
		current=!current
