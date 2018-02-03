extends Node

var ip = "127.0.0.1"
var SERVER_PORT = 3000

func _ready():
	get_tree().connect("network_peer_connected", self, "_player_connected")
	get_tree().connect("network_peer_disconnected", self, "_player_disconnected")
	get_tree().connect("connected_to_server", self, "_connected_ok")
	get_tree().connect("connection_failed", self, "_connected_fail")
	get_tree().connect("server_disconnected", self, "_server_disconnected")
	
	#var chatlog = get_node("Panel/RichTextLabel")
	#chatlog.set_scroll_follow(true)
	#pass
	
func create_server():
	var host = NetworkedMultiplayerENet.new()
	host.create_server(SERVER_PORT, 4)
	get_tree().set_network_peer(host)
	print("server create")

func connect_client(): 
	var host = NetworkedMultiplayerENet.new()
	host.create_client(ip, SERVER_PORT)
	get_tree().set_network_peer(host)
	print("connect client")
	
# Player info, associate ID to data
var player_info = {}
# Info we send to other players
var my_info = { name = "Johnson Magenta", favorite_color = Color8(255, 0, 255) }

func _player_connected(id):
	print("connected")
	#var chatlog = get_node("Panel/RichTextLabel")
	#chatlog.add_text("connected!" + "\n")
	pass # Will go unused, not useful here
	
func _player_disconnected(id):
	#var chatlog = get_node("Panel/RichTextLabel")
	#chatlog.add_text("disconnected!" + "\n")
	player_info.erase(id) # Erase player from info

func _connected_ok():
	#var chatlog = get_node("Panel/RichTextLabel")
	#chatlog.add_text("connected!" + "\n")
	# Only called on clients, not server. Send my ID and info to all the other peers
	rpc("register_player", get_tree().get_network_unique_id(), my_info)
	
func _server_disconnected():
	#var chatlog = get_node("Panel/RichTextLabel")
	#chatlog.add_text("_server_disconnected!" + "\n")
	print("_server_disconnected")
	pass # Server kicked us, show error and abort

func _connected_fail():
	#var chatlog = get_node("Panel/RichTextLabel")
	#chatlog.add_text("_server_disconnected!" + "\n")
	print("_connected_fail")
	pass # Could not even connect to server, abort

remote func message_player(text):
	print("messages",text)
	#var chatlog = get_node("Panel/RichTextLabel")
	#chatlog.add_text(text + "\n")
	
master func chatmessage(value):
	rpc("message_player",value)
	
remote func register_player(id, info):
	# Store the info
	player_info[id] = info
	# If I'm the server, let the new guy know about existing players
	if (get_tree().is_network_server()):
		# Send my info to new player
		rpc_id(id, "register_player", 1, my_info)
		# Send the info of existing players
		for peer_id in player_info:
			rpc_id(id, "register_player", peer_id, player_info[peer_id])
	# Call function to update lobby UI here
	
	
func _on_btnserver_pressed():
	create_server()
	#var chatlog = get_node("Panel/RichTextLabel")
	#chatlog.add_text("server created.." + "\n")
	pass
	
func _on_btnclient_pressed():
	connect_client()
	#var chatlog = get_node("Panel/RichTextLabel")
	#chatlog.add_text("client connecting.." + "\n")
	pass
	
func _on_btntest_pressed():
	
	pass
	
func _on_LineEdit_text_entered( text ):
	#print(text)
	#chatlog.set_scroll_follow(true)
	#chatlog.append_bbcode(text + "\n")
	#var chatlog = get_node("Panel/RichTextLabel")
	#chatlog.add_text(text + "\n")
	#chatmessage(text)
	
	pass
