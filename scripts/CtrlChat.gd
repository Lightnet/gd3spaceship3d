extends Control

var path_network = "/root/network"
var network = null

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	var chatlog = get_node("Panel_Chat/RichTextLabel")
	chatlog.set_scroll_follow(true)
	
	if network == null:
		network = get_node(path_network)
		network.chatnode = self; #assign node
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func message(value):
	var chatlog = get_node("Panel_Chat/RichTextLabel")
	chatlog.add_text(value + "\n")
	pass

func _on_BtnStartServer_pressed():
	network.create_server();
	var chatlog = get_node("Panel_Chat/RichTextLabel")
	chatlog.add_text("server created.." + "\n")
	pass # replace with function body

func _on_BtnStartClient_pressed():
	network.connect_client();
	var chatlog = get_node("Panel_Chat/RichTextLabel")
	chatlog.add_text("client connecting.." + "\n")
	pass # replace with function body

func _on_BtnSendTest_pressed():
	var chatlog = get_node("Panel_Chat/RichTextLabel")
	chatlog.add_text("test" + "\n")
	network.chatmessage("test")
	
	pass # replace with function body


func _on_BtnSpawn_pressed():
	network.setup_config_game()
	pass # replace with function body

func _on_LineEdit_Chat_text_entered( new_text ):
	#print(new_text)
	var chatlog = get_node("Panel_Chat/RichTextLabel")
	chatlog.set_scroll_follow(true)
	chatlog.append_bbcode(new_text + "\n")
	network.chatmessage(new_text)
	pass # replace with function body
