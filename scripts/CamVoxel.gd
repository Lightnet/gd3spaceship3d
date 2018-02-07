extends Camera

const BlockVoxel = preload("res://objects/KBVoxel.tscn")

var offset = Vector3(0.5,0.5,0.5)
var ray_length = 10
var point
var ROT_SPEED = 0.1
var bhit = false

var placeposition = Vector3(0,0,0)

var label01
var label02

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	point = get_node("../MeshInstance")
	label01 = get_node("../../Control/Label")
	label02 = get_node("../../Control/Label2")
	pass

func _input(ev):
	#print(ev)
	#if ev is InputEventMouseButton:
	if ev is InputEventMouseMotion:
		#get camera
		var camera = self #get_node("Camera
		#get camera view mouse position
		var from = camera.project_ray_origin(ev.position)
		#face direction vector3 placeholder position
		var to = from + camera.project_ray_normal(ev.position) * ray_length
		
		#setup for y axis zero plane
		var view = camera.project_ray_normal(ev.position)
		#normal vector to 0.0 - 1.0
		var dir = view.normalized()
		#Camera Position and direction target position
		var distance = - camera.transform.origin.y / dir.y;
		# caluate y axis convert to x and z axis plane from mouse x and y position
		var pos = Vector3(camera.transform.origin.x,camera.transform.origin.y,camera.transform.origin.z) + dir * distance
		
		#ray cast hit block
		var directState = PhysicsServer.space_get_direct_state(camera.get_world().get_space())
		var result = directState.intersect_ray(from, to, [self])
		
		bhit = false
		if result.size() != 0:
			bhit = true
			#print("?")
			#print(result)
			#result.normal
			pos = result.position
			label01.set_text("Normal x:" + String(result.normal.x)+" y:" + String(result.normal.y) +" x:" + String(result.normal.z))
			label02.set_text("Hit x:" + String(pos.x)+" y:" + String(pos.y) +" x:" + String(pos.z))
			pos.x = round(pos.x)
			pos.y = round(pos.y)
			pos.z = round(pos.z)
			if result.normal.x != 0:
				pos.x = round(pos.x) + result.normal.x * 1
			if result.normal.y != 0:
				pos.y = round(pos.y) + result.normal.y * 1
			if result.normal.z != 0:
				pos.z = round(pos.z) + result.normal.z * 1
			print(pos)
		#point.transform.origin = to
		if bhit:
			placeposition = pos
			pass
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
			
			var objvoxel = BlockVoxel.instance()
			objvoxel.transform.origin = placeposition
			get_node("/root/Node/Spatial").add_child(objvoxel)
			
			pass
		pass