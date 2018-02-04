extends Node

var ip = "127.0.0.1"
var SERVER_PORT = 3000
var chatnode = null

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
	#get_tree().set_meta("network_peer", peer)
	print("server create")

func connect_client(): 
	var host = NetworkedMultiplayerENet.new()
	host.create_client(ip, SERVER_PORT)
	get_tree().set_network_peer(host)
	#get_tree().set_meta("network_peer", peer)
	print("connect client")
	
# Player info, associate ID to data
var player_info = {}
# Info we send to other players
var my_info = { name = "Johnson Magenta", favorite_color = Color8(255, 0, 255) }

func _player_connected(id):
	print("connected")
	if chatnode !=null:
		chatnode.message("connected!")
	pass # Will go unused, not useful here
	
func _player_disconnected(id):
	if chatnode !=null:
		chatnode.message("disconnected!")
	player_info.erase(id) # Erase player from info

func _connected_ok():
	if chatnode !=null:
		chatnode.message("connected!")
	# Only called on clients, not server. Send my ID and info to all the other peers
	rpc("register_player", get_tree().get_network_unique_id(), my_info)
	
func _server_disconnected():
	if chatnode !=null:
		chatnode.message("_server_disconnected!")
	
	#var chatlog = get_node("root/scene")
	#print(chatlog)
	print("_server_disconnected")
	pass # Server kicked us, show error and abort

func _connected_fail():
	if (chatnode !=null):
		chatnode.message("_server_disconnected!")
	print("_connected_fail")
	pass # Could not even connect to server, abort

remote func message_player(text):
	print("messages",text)
	if chatnode !=null:
		chatnode.message(text)
	
master func chatmessage(value):
	rpc("message_player",value)
	
remote func register_player(id, info):
	# Store the info
	player_info[id] = info
	# If I'm the server, let the new guy know about existing players
	if get_tree().is_network_server():
		# Send my info to new player
		rpc_id(id, "register_player", 1, my_info)
		# Send the info of existing players
		for peer_id in player_info:
			rpc_id(id, "register_player", peer_id, player_info[peer_id])
	# Call function to update lobby UI here

remote func spawn_player(id):
	var selfPeerID = id
	var my_player = preload("res://objects/KBPlayerCube.tscn").instance()
	my_player.set_name(str(selfPeerID))
	my_player.set_network_master(selfPeerID) # Will be explained later
	get_node("/root/Node/players").add_child(my_player)
	pass

master func spawn():

	var selfPeerID = get_tree().get_network_unique_id()
	var my_player = preload("res://objects/KBPlayerCube.tscn").instance()
	#print(my_player)
	my_player.set_name(str(selfPeerID))
	my_player.set_network_master(selfPeerID) # Will be explained later

	my_player.get_node("Camera").current = true

	#var pos = Vector3(round(rand_range(0,5)),5,round(rand_range(0,5)))
	#var pos = Vector3(0,0,0)
	#my_player.transform.origin = pos
	get_node("/root/Node/players").add_child(my_player)

	for p in player_info:
		print(p)
		rpc_id(p, "spawn_player", selfPeerID)
	pass

remote func pre_configure_game(selfPeerID):
	#get_tree().set_pause(true) # Pre-pause
	#var selfPeerID = get_tree().get_network_unique_id()
	print("peer ID:",selfPeerID)
	# Load world
	#var world = load(which_level).instance()
	#get_node("/root").add_child(world)

	# Load my player #master
	var my_player = preload("res://objects/KBPlayerCube.tscn").instance()
	print(my_player)
	my_player.set_name(str(selfPeerID))
	my_player.set_network_master(selfPeerID) # Will be explained later
	var pos = Vector3(round(rand_range(0,5)),5,round(rand_range(0,5)))
	#var pos = Vector3(0,0,0)
	my_player.transform.origin = pos
	get_node("/root/Node/players").add_child(my_player)
	
	# Load other players #slave
	"""
	for p in player_info:
		print("slave?")
		var player = preload("res://objects/KBPlayerCube.tscn").instance()
		print("peer ID:",str(p))
		player.set_name(str(p))
		player.set_network_master(p) #set unique id as master
		
		pos = Vector3(round(rand_range(0,5)),5,round(rand_range(0,5)))
		player.set_pos(pos);
		get_node("/root/Node/players").add_child(player)
	
	"""
	# Tell server (remember, server is always ID=1) that this peer is done pre-configuring
	rpc_id(1, "done_preconfiguring", selfPeerID)
	pass

#master func setup_config_game():
master func setup_config_game():
	print("setup game?");
	assert(get_tree().is_network_server())
	print("server?");
	#player_info
	#rpc("pre_configure_game")
	var selfPeerID = get_tree().get_network_unique_id()
	var my_player = preload("res://objects/KBPlayerCube.tscn").instance()
	my_player.set_name(str(selfPeerID))
	my_player.set_network_master(selfPeerID) # Will be explained later
	#var pos = Vector3(round(rand_range(0,3)),5,round(rand_range(0,3)))
	var pos = Vector3(0,0,0)
	get_node("/root/Node/players").add_child(my_player)
	
	#rpc_id(p, "pre_configure_game",selfPeerID)
	
	#for p in player_info:
		#rpc_id(p, "pre_configure_game",selfPeerID)
	
	
	#get_tree().set_pause(true) # Pre-pause
	
	#print("peer ID:",selfPeerID)
	
	#print(my_player)
	
	#my_player.transform.origin = pos
	#my_player.position.x = pos.x
	#my_player.position.z = pos.z
	#get_node("/root/Node/players").add_child(my_player)
	#rpc("pre_configure_game")
	pass

var players_done = []

remote func done_preconfiguring(who):
	# Here is some checks you can do, as example
	assert(get_tree().is_network_server())
	assert(who in player_info) # Exists
	assert(not who in players_done) # Was not added yet

	players_done.append(who)

	if (players_done.size() == player_info.size()):
		rpc("post_configure_game")

remote func post_configure_game():
	get_tree().set_pause(false)
	# Game starts now!











	
