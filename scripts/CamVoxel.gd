extends Camera

var offset = Vector3(0.5,0.5,0.5)
var ray_length = 10
var point
var ROT_SPEED = 0.1
var bhit = false

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
			print(result)
			#result.normal
			#result.position
			if result.normal.x == 1 or result.normal.x == -1:
				pos.x = round(pos.x) + result.normal.x * 0.5
			if result.normal.y >= 0.8 or result.normal.y <= -0.8:
				pos.y = round(pos.y) + result.normal.y * 2
			if result.normal.z >= 0.8 or result.normal.z <= -0.8:
				pos.z = round(pos.z) + result.normal.z * 0.5
			pos.x = round(pos.x)
			pos.y = round(pos.y)
			pos.z = round(pos.z)
		#point.transform.origin = to
		#if bhit:
			#pass
		#else:
		point.transform.origin = pos
		#print("Move")
		
		
		
	#point.transform.origin = point
	#print(to)

	var dir = Vector3() # Where does the player intend to walk to
	var cam_xform = get_global_transform() #forward direction
	if Input.is_key_pressed(KEY_W):
		dir += -cam_xform.basis[2]
		transform.origin = transform.origin + dir
		pass
	if Input.is_key_pressed(KEY_S):
		dir += cam_xform.basis[2]
		transform.origin = transform.origin + dir
		pass
	if Input.is_key_pressed(KEY_A):
		rotate(Vector3(0, 1, 0), deg2rad(10 * ROT_SPEED))
		pass
	if Input.is_key_pressed(KEY_D):
		rotate(Vector3(0, 1, 0), deg2rad(-10 * ROT_SPEED))
	
	if ev is InputEventMouseButton:
		if ev.button_index == BUTTON_LEFT and ev.pressed:
			print("LEFT MOUSE PRESS")
			pass
		pass