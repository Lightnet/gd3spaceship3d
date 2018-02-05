extends RigidBody

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_SphereProjecile_body_entered( body ):
	#body.get
	print(body.get_name())
	print("hit?")
	#queue_free()
	pass # replace with function body
