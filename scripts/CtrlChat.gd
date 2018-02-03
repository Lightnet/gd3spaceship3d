extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var path_network = "/root/network"
var network = null

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	if network == null:
		network = get_node(path_network)
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_BtnStartServer_pressed():
	network.create_server();
	pass # replace with function body


func _on_BtnStartClient_pressed():
	network.connect_client();
	pass # replace with function body


func _on_BtnSendTest_pressed():
	if (get_tree().is_networking_server()):
		network.chatmessage("test")
	else:
		print("network net setup?")
	pass # replace with function body
