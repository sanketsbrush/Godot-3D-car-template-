extends Label
@onready var car: VehicleBody3D = $".."

func _process(_delta: float) -> void:
	text ="fps: %d\nspeed: %d"%[Engine.get_frames_per_second(),abs(int(car.speed))]
