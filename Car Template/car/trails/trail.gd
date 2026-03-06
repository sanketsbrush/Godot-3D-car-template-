#class_name Trail3D 
extends MeshInstance3D
@onready var car: VehicleBody3D = $"../../.."
@onready var ground_sensor:RayCast3D =car.get_node("ground_sensor")


var points:=[]
var widths:=[]
var lifePoints:=[]

var trailEnabled:=true

var fromWidth:float
var toWidth:float
var scaleAcceleration:=1.0
var motionDelta:=0.1
var lifespan:=10

var scaleTexture:=true
var startColor = Color(0,0,0,0.5)
var endColor = Color(0,0,0,0.1)

var oldPos

func _ready():
	#rotation_degrees=Vector3(0,0,-180)
	oldPos = get_global_transform().origin
	mesh = ImmediateMesh.new()
	fromWidth=0.2
	toWidth=0.2

func _physics_process(delta: float) -> void:
	
	if (car.speed>200 and bool(abs(car.steering_signal))) or bool(car.drift_signal):
		fromWidth=0.2*float(ground_sensor.is_colliding())
		toWidth=0.2*float(ground_sensor.is_colliding())
	else:
		fromWidth=0
		toWidth=0

	#if car.speed>100 and bool(abs(car.steering_signal)) or bool(car.drift_signal):
		#fromWidth=0.2
		#toWidth=0.2
	#else:
		#fromWidth=0
		#toWidth=0
	
	if (oldPos - get_global_transform().origin).length() > motionDelta and trailEnabled:
		appendPoint()
		oldPos = get_global_transform().origin
	
	var p = 0
	var max_points = points.size()
	while p < max_points:
		lifePoints[p] += delta
		if lifePoints[p] > lifespan:
			removePoint(p)
			p -= 1
			if (p < 0): p = 0
		
		max_points = points.size()
		p += 1
	
	mesh.clear_surfaces()
	
	if points.size() < 2:
		return
	
	mesh.surface_begin(Mesh.PRIMITIVE_TRIANGLE_STRIP)
	for i in range(points.size()):
		var t = float(i) / (points.size() - 1.0)
		#var currColor = startColor.lerp(endColor, 1 - t)
		#mesh.surface_set_color(currColor)
		
		var currWidth = widths[i][0] - pow(1-t, scaleAcceleration) * widths[i][1]
		
		if scaleTexture:
			var t0 = motionDelta * i
			var t1 = motionDelta * (i + 1)
			mesh.surface_set_uv(Vector2(t0, 0))
			mesh.surface_add_vertex(to_local(points[i] + currWidth))
			mesh.surface_set_uv(Vector2(t1, 1))
			mesh.surface_add_vertex(to_local(points[i] - currWidth))
		else:
			var t0 = i / points.size()
			var t1 = t
			
			mesh.surface_set_uv(Vector2(t0, 0))
			mesh.surface_add_vertex(to_local(points[i] + currWidth))
			mesh.surface_set_uv(Vector2(t1, 1))
			mesh.surface_add_vertex(to_local(points[i] - currWidth))
	mesh.surface_end()

func appendPoint():
	points.append(get_global_transform().origin)
	widths.append([
		get_global_transform().basis.x * fromWidth,
		get_global_transform().basis.x * fromWidth - get_global_transform().basis.x * toWidth])
	lifePoints.append(0.0)
	
func removePoint(i):
	points.remove_at(i)
	widths.remove_at(i)
	lifePoints.remove_at(i)
