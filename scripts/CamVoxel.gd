extends Camera

var offset = Vector3(0.5,0.5,0.5)
var ray_length = 10

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
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
		var point = get_node("../MeshInstance")
		
		var directState = PhysicsServer.space_get_direct_state(camera.get_world().get_space())
		var result = directState.intersect_ray(from, to, [self])
		if result.size() != 0:
			print("?")
			pass
		
		
		point.transform.origin = to
		#print("Move")
	#point.transform.origin = point
	#print(to)