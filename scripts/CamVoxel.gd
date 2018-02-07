extends Camera

var offset = Vector3(0.5,0.5,0.5)
var ray_length = 10
var point

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	point = get_node("../MeshInstance")
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _input(ev):
	#print(ev)
	#if ev is InputEventMouseButton:
	if ev is InputEventMouseMotion:
		var camera = self #get_node("Camera")
		var from = camera.project_ray_origin(ev.position)
		var to = from + camera.project_ray_normal(ev.position) * ray_length
		#var view = get_viewport().get_camera().unproject_position(get_global_transform().origin)
		var view = camera.project_ray_normal(ev.position)
		var dir = view.normalized()
		var distance = - camera.transform.origin.y / dir.y;
		var pos = Vector3(camera.transform.origin.x,camera.transform.origin.y,camera.transform.origin.z) + dir * distance
		
		var directState = PhysicsServer.space_get_direct_state(camera.get_world().get_space())
		var result = directState.intersect_ray(from, to, [self])
		if result.size() != 0:
			#print("?")
			pass
		#point.transform.origin = to
		point.transform.origin = pos
		#print("Move")
	#point.transform.origin = point
	#print(to)