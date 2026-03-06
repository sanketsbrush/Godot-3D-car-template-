extends Node3D
var r:=0
@onready var car: VehicleBody3D = $".."

func _on_car_body_entered(_body: Node) -> void:

	if car.speed<50:
		get_child(randi_range(0,2)).volume_db=-20
		get_child(randi_range(0,2)).playing=true
	elif car.speed<200:
		get_child(randi_range(0,2)).volume_db=-10
		get_child(randi_range(0,2)).playing=true
	else:
		get_child(randi_range(0,2)).volume_db=0
		get_child(randi_range(0,2)).playing=true
