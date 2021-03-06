extends KinematicBody

const ACCEL= 2
const DEACCEL= 4
const MAX_SPEED = 10
slave var slave_vel = Vector3()

onready var cam = get_node("Camera")
const Status = preload("res://scripts//status.gd") # Relative path
onready var status = Status.new()
const projectile = preload("res://objects/RBSphereProjectile.tscn")
var global = null

var bfirepress = false

var ROT_SPEED = 0.1

func _physics_process(delta):
	if global.bnetwork == false:
		var dir = Vector3() # Where does the player intend to walk to
		var cam_xform = cam.get_global_transform()
		if Input.is_key_pressed(KEY_W):
			dir += -cam_xform.basis[2]
		if Input.is_key_pressed(KEY_S):
			dir += cam_xform.basis[2]
		# Godot 2
		#var axis = self.get_transform().basis.xform(Vector3(1,2,3)).normalized()
		#self.rotate(axis,angle) 
			
		if Input.is_key_pressed(KEY_A):
			#dir += -cam_xform.basis[0
			#transform
			rotate(Vector3(0, 1, 0), deg2rad(10 * ROT_SPEED))
			
			pass
		if Input.is_key_pressed(KEY_D):
			#dir += cam_xform.basis[0]
			rotate(Vector3(0, 1, 0), deg2rad(-10 * ROT_SPEED))
			pass
			
			
		dir.y = 0
		dir = dir.normalized()
		var hvel = slave_vel
		hvel.y = 0
		var target = dir*MAX_SPEED
		var accel
		if dir.dot(hvel) > 0:
			accel = ACCEL
		else:
			accel = DEACCEL
		hvel = hvel.linear_interpolate(target, accel*delta)
		slave_vel.x = hvel.x
		slave_vel.z = hvel.z
		move_and_collide(slave_vel*delta)
	#pass
	
func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	pass

func _input(ev):
	# Mouse in viewport coordinates
	#if (ev is InputEventMouseButton):
		#print("Mouse Click/Unclick at: ",ev.position)
	#elif (ev is InputEventMouseMotion):
		#print("Mouse Motion at: ",ev.position)
	# Print the size of the viewport
	#print("Viewport Resolution is: ", get_viewport_rect().size)
	
	if Input.is_key_pressed(KEY_D) or Input.is_key_pressed(KEY_RIGHT):
		#print("->")
		pass
	if Input.is_key_pressed(KEY_A) or Input.is_key_pressed(KEY_LEFT):
		#print("<-")
		pass
	if Input.is_key_pressed(KEY_SPACE):
		if bfirepress == false:
			bfirepress = true
			var cam_xform = cam.get_global_transform()
			var face = -cam_xform.basis[2]
			face.y = 0
			face = face.normalized()
			#var target = face*MAX_SPEED
			var target = face*2
			var objprojectile = projectile.instance()
			objprojectile.transform.origin = transform.origin + target
			objprojectile.apply_impulse(transform.origin,target*10)
			get_node("/root/Node").add_child(objprojectile)
			print(face)
	else:
		bfirepress = false
		
		pass
	
	pass

func set_player_name(new_name):
	#get_node("label").set_text(new_name)
	pass

func _ready():
	global = get_node("/root/global")
	#cam = get_node("Camera"))
	set_physics_process(true)
	set_process_input(true)
	#print(status.health)
	pass