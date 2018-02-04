Notes:
 * Just place here simple create current client to create/spawn player.

```python
remote func spawn_player(id): #client
	var selfPeerID = id
	var my_player = preload("res://objects/KBPlayerCube.tscn").instance()
	my_player.set_name(str(selfPeerID))
	my_player.set_network_master(selfPeerID) # Will be explained later
	get_node("/root/Node/players").add_child(my_player)
	pass

master func spawn(): #server
	var selfPeerID = get_tree().get_network_unique_id()
	var my_player = preload("res://objects/KBPlayerCube.tscn").instance()
	my_player.set_name(str(selfPeerID))
	my_player.set_network_master(selfPeerID) # Will be explained later
	my_player.get_node("Camera").current = true #set current camera owner client to this camera when spawn.
	get_node("/root/Node/players").add_child(my_player)

	for p in player_info: #player list send to clients
		print(p)
		rpc_id(p, "spawn_player", selfPeerID)
	pass
```