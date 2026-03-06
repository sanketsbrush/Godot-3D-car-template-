extends VehicleWheel3D
@onready var car: VehicleBody3D = $".."


func _ready() -> void:
#wheel
	wheel_roll_influence = 1.0
	wheel_radius = 0.4
	wheel_rest_length = 0.2
	wheel_friction_slip = 5.0
#suspension
	suspension_travel = 1.0
	suspension_stiffness = 100.0
	suspension_max_force = 2000.0
