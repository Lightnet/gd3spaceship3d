extends Spatial

const projectile = preload("res://objects/RBSphereProjectile.tscn")

var mouse_pos = Vector2()
var dir = Vector3()

func _input(event):
	if event is InputEventMouseMotion:
		mouse_pos = Vector2(event.position.x,event.position.y)#event.pos to Vector2()
	if event is InputEventMouseButton:
		print("press")
		var cam_xform = get_global_transform()
		#face forward normal direction
		#var face = -cam_xform.basis[2]
		var face = cam_xform.basis[2]
		face.y = 0
		face = face.normalized()
		var target = face*3
		var objprojectile = projectile.instance()
		objprojectile.transform.origin = transform.origin + target
		objprojectile.apply_impulse(transform.origin,target*10)
		get_node("/root/Node").add_child(objprojectile)
		#pass
	#pass

func _process(delta):
	#	# Called every frame. Delta is time since last frame.
	#	# Update game logic here.
		# Get the camera (just an example)
		var camera = get_parent().get_node("Camera")
		# Project mouse into a 3D ray
		var ray_origin = camera.project_ray_origin(mouse_pos)
		var ray_direction = camera.project_ray_normal(mouse_pos)
		# Cast a ray
		var from = ray_origin
		var to = ray_origin + ray_direction * 1000.0
		var space_state = get_world().get_direct_space_state()
		var hit = space_state.intersect_ray(from, to)
		if hit.size() != 0:
			# collider will be the node you hit
			#print(hit.collider)
			var point = get_parent().get_node("Point")
			#print(hit.position)
			point.transform.origin = hit.position
			dir = (hit.position - get_global_transform().origin).normalized()
			#settings face dir*-1 
			var face = dir*-1
			#dir = (get_global_transform().origin - hit.position).normalized()
			#print(dir)
			look_at(face,Vector3(0,1,0))
		#pass
	#pass

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
