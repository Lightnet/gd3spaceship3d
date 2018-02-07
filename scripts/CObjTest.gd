extends Control

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


func _on_Button_pressed():
	print("test...")
	var player = get_node("../../Spatial/RigidBodyPlayer")
	print(player.get_name())
	#print(player.get_collision_layer_bit(0))
	print(player.get_collision_layer_bit(1))
	
	pass # replace with function body
