extends AudioStreamPlayer3D
@onready var car: VehicleBody3D = $".."
@onready var ground_sensor: RayCast3D = $"../ground_sensor"

func _process(_delta: float) -> void:
	volume_db= (int( ground_sensor.is_colliding())*100)-50
	if (car.speed>25 and bool(car.brake_signal))or bool(car.drift_signal):
		pitch_scale=lerpf(pitch_scale,1.0,0.75)
	else:pitch_scale=lerpf(pitch_scale,0.01,0.75)
