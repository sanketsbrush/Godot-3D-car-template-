extends AudioStreamPlayer3D

@onready var car: VehicleBody3D = $".."

func _process(_delta: float) -> void:
	
	if bool(car.drift_signal):pitch_scale=lerpf(pitch_scale,3,0.05)
	elif bool(abs(car.engine_signal)):pitch_scale=lerpf(pitch_scale,(car.speed*0.01),0.05)
	else:pitch_scale=lerpf(pitch_scale,0,0.05)
