extends AudioStreamPlayer3D
@onready var car: VehicleBody3D = $".."

@onready var ground_sensor: RayCast3D = car.get_node("ground_sensor")

func _process(_delta: float) -> void:
	if ground_sensor.is_colliding():
		pitch_scale=lerpf(pitch_scale,car.speed*0.02+0.01,0.25)
	else:pitch_scale=lerpf(pitch_scale,0.01,0.25)
