extends Node

var camera
var mouse_pos = Vector2()
var point
var dir = Vector3()
var skeleton

var boneid

func _ready():
	camera = get_node("/root/Node/Spatial/Camera")
	#print(camera)
	point = get_node("/root/Node/Spatial/Point")
	skeleton = get_node("Armature/Skeleton")
	#print(skeleton)
	#print(skeleton.find_bone("Armature_Base"))
	#print(skeleton.find_bone("Armature_turret"))
	set_process(true)

	var bonename = "Base"
	#bonename = "turret"
	boneid = skeleton.find_bone(bonename)
	#pass
	
func _input(event):
	if event is InputEventMouseMotion:
		mouse_pos = Vector2(event.position.x,event.position.y)#event.pos to Vector2()

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	
	# Project mouse into a 3D ray
	var ray_origin = camera.project_ray_origin(mouse_pos)
	var ray_direction = camera.project_ray_normal(mouse_pos)
	
	# Cast a ray
	var from = ray_origin
	var to = ray_origin + ray_direction * 1000.0
	var space_state = get_world().get_direct_space_state()
	var hit = space_state.intersect_ray(from, to)
	if hit.size() != 0:
		point.transform.origin = hit.position
		dir = (hit.position - get_global_transform().origin)#.normalized()
		var face = dir*-1
		var base = face
		base.y = 0
		#look_at(base,Vector3(0,1,0))
		#var boneid = skeleton.find_bone("Armature_Base")
		#var turret_base = skeleton.get_bone_pose(boneid)
		#turret_base.look_at(base,Vector3(0,1,0))
		#turret_base.looking_at(base,Vector3(0,1,0))
		#turret_base.rotated( Vector3(0,1,0), deg2rad(10) * delta)
		#skeleton.set_bone_pose( boneid, turret_base )
		#rotate( Vector3(0,1,0), deg2rad(10) )#works
		point.transform.origin = hit.position
		#pass
	
	var turret_base = skeleton.get_bone_pose(boneid)
	#turret_base = turret_base.rotated( Vector3(0,1,0), deg2rad(10) * delta)
	#turret_base = turret_base.rotated( Vector3(0,1,0), 100*  delta)
	#print(turret_base)
	dir= dir*-1
	turret_base = turret_base.looking_at(dir,Vector3(0,1,0))
	skeleton.set_bone_pose( boneid, turret_base )
	#skeleton.rotate( Vector3(0,1,0), deg2rad(10) * delta)
	#print("test")
	pass
