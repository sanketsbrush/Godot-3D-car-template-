extends RayCast3D
var hit:=false
@onready var r1: RayCast3D = $r1
@onready var r2: RayCast3D = $r2
@onready var r3: RayCast3D = $r3
@onready var r4: RayCast3D = $r4

func _ready() -> void:
	for i in get_child_count():
		get_child(i-1).collision_mask=collision_mask
		get_child(i-1).enabled=enabled
		get_child(i-1).target_position=target_position

func _physics_process(_delta: float) -> void:
	hit=bool(int(r1.is_colliding())+int(r2.is_colliding())+int(r3.is_colliding())+int(r4.is_colliding()))
