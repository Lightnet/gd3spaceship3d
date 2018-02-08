extends Control

var config

var game_difficulty
var popup

func _ready():
	config = get_node("/root/settings")
	
	game_difficulty = get_node("Panel/TabContainer/Game/VScrollBar/VBoxContainer/HBoxContainer_Game/MenuButton")
	
	popup = game_difficulty.get_popup()
	popup.add_item("Normal")
	popup.add_item("Hard")
	popup.connect("id_pressed", self, "_on_item_pressed")
	#pass

func _on_item_pressed(ID):
	var pop  = game_difficulty.get_popup()
	print(pop.get_item_text(ID))
	print("ID:"+String(ID))
	print("press")
	pass
	
func _on_Button_pressed():
	hide()
	get_parent().get_node("ctrl_mainmenu").show()
	
func _on_BtnApply_pressed():
	#config = get_node("/root/settings")
	#print(config)
	print(config._settings.profile.username)
	#pass
