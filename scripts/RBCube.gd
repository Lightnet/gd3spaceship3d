extends RigidBody

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_physics_process(true)
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _physics_process(delta):
	#print("_physics_process")
	#if self.():
		#print (self.get_collider().get_name())
	pass

func _on_RigidBody_body_entered( body ):
	#var collision_position = local_collision_pos + get_translation()
	#print(collision_position)
	
	#body.get
	print(body.get_name())
	print("hit?")
	pass # replace with function body
