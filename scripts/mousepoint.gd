extends Spatial

var mouse_pos = Vector2()

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _input(event):
	#if event.type == InputEvent.MOUSE_MOTION:
	if event is InputEventMouseMotion:
		mouse_pos = Vector2(event.position.x,event.position.y)#event.pos to Vector2()
		#print(mouse_pos)
	pass

func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	#print("test")
	
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
		print(hit.position)
		point.transform.origin = hit.position
	
	pass
