extends KinematicBody

const ACCEL= 2
const DEACCEL= 4
const MAX_SPEED = 10

var vel = Vector3()

onready var cam = get_node("Camera")


func _physics_process(delta):
    #move(direction * delta)
	#print("_physics_process")
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	var dir = Vector3() # Where does the player intend to walk to
	var cam_xform = cam.get_global_transform()
	if Input.is_key_pressed(KEY_W):
		dir += -cam_xform.basis[2]
	if Input.is_key_pressed(KEY_S):
		dir += cam_xform.basis[2]
	if Input.is_key_pressed(KEY_A):
		dir += -cam_xform.basis[0]
	if Input.is_key_pressed(KEY_D):
		dir += cam_xform.basis[0]
	dir.y = 0
	dir = dir.normalized()
	var hvel = vel
	hvel.y = 0
	var target = dir*MAX_SPEED
	var accel
	if (dir.dot(hvel) > 0):
		accel = ACCEL
	else:
		accel = DEACCEL
	hvel = hvel.linear_interpolate(target, accel*delta)
	vel.x = hvel.x
	vel.z = hvel.z
	print(vel)
	move_and_collide(vel*delta)
	#move(vel*delta)
	
	pass

func _input(ev):
	# Mouse in viewport coordinates
	#if (ev is InputEventMouseButton):
		#print("Mouse Click/Unclick at: ",ev.position)
	#elif (ev is InputEventMouseMotion):
		#print("Mouse Motion at: ",ev.position)
	# Print the size of the viewport
	#print("Viewport Resolution is: ", get_viewport_rect().size)
	
	if(Input.is_key_pressed(KEY_D) or Input.is_key_pressed(KEY_RIGHT)):
		#print("->")
		pass
	if(Input.is_key_pressed(KEY_A) or Input.is_key_pressed(KEY_LEFT)):
		#print("<-")
		#var hVector = Vector3(0,0,1)
		pass
		#self.move(hVector)
	
	pass


func _ready():
	#cam = get_node("Camera"))
	set_physics_process(true)
	set_process_input(true)
	
	pass


