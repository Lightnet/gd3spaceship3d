extends RigidBody

const ACCEL= 2
const DEACCEL= 4
const MAX_SPEED = 1
slave var slave_vel = Vector3()

var excludes = []

func _ready():
	print("get_rid:",get_rid())
	
	excludes.append(get_rid())
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _physics_process(delta):
	var dir = Vector3()
	var xform = get_global_transform()
	if Input.is_key_pressed(KEY_W):
		dir += -xform.basis[2]
	if Input.is_key_pressed(KEY_S):
		dir += xform.basis[2]
	if Input.is_key_pressed(KEY_A):
		dir += -xform.basis[0]
	if Input.is_key_pressed(KEY_D):
		dir += xform.basis[0]
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
	#move_and_collide(slave_vel*delta)
	apply_impulse(transform.origin,slave_vel)
	var space_state = get_world().get_direct_space_state()
	
	
	#var params = PhysicsShapeQueryParameters
	#params.set_shape(get_node("CollisionShape").get_shape())
	#params.set_transform(get_transform().translated(transform.origin)) # same transform as parent, just translate
	#params.set_motion(slave_vel*5) # is "motion" the sweep distance?
	#var space_state = get_world().get_direct_space_state(params,1)
	
	#var results = space_state.collide_shape(PhysicsShapeQueryParameters,1)
	#var results = space_state.collide_shape(get_node("CollisionShape").shape_owner_get_shape(),1)
	#var results = space_state.collide_shape(get_node("CollisionShape").get_shape(),1)
	#var results = space_state.collide_shape(get_shape(),1)
	
	#var params = PhysicsShapeQueryParameters.new()
	#params.set_shape(get_node("CollisionShape").get_shape())
	
	#var results = space_state.collide_shape(params, 1)
	#if results.size() != 0:
		#print("hit?")
		
		
	var sphere = SphereShape.new()
	sphere.radius = 1
	var params = PhysicsShapeQueryParameters.new()
	params.set_shape(sphere)
	#params.set_transform(get_transform().translated(transform.origin)) # same transform as parent, just translate
	
	params.set_transform(get_transform())  #work
	
	#if excludes != null:
    #   params.set_exclude(excludes) # here exclude is an array of... RID??
	params.set_exclude(excludes) # here exclude is an array of... RID??
	
	#set_collision_layer_bit(
	
	
	#params.set_collision_mask(2)
	var state = get_world().get_direct_space_state()
	var results = state.intersect_shape(params, 2)
	#var results = state.collide_shape(params, 26)
	#print(results.size())
	if results.size() != 0:
		print(results[0])
		#print(results[0].collider.get_name())
		#if results[0].collider.get_name() == get_name() :
			#excludes.append(results[0].collider_id)
			#excludes.append(results[0].rid)
			#pass
		
		pass
	
	

func _on_RigidBody_body_entered( body ):
	print("hit body...")
	pass # replace with function body


func _on_RigidBody_body_shape_entered( body_id, body, body_shape, local_shape ):
	print("hit shape body...")
	pass # replace with function body

