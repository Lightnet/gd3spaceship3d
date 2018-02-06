extends RigidBody

var damage = 10

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
	print("====================")
	print(body.get_name())
	print("hit?")
	if body.get_name() == "KBPlayerShipCubeBot":
		if body.has_method("onDamage"):
			body.onDamage(damage)
			queue_free()
		pass
		
	#queue_free()
	pass # replace with function body
