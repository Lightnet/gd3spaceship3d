extends Control

var settings

var game_difficulty
var popup

func _on_Button_pressed():
	hide()
	get_parent().get_node("ctrl_mainmenu").show()
	
func _ready():
	settings = get_node("/root/settings")
	
	
	game_difficulty = get_node("Panel/TabContainer/Game/VScrollBar/VBoxContainer/HBoxContainer_Game/MenuButton")
	popup = game_difficulty.get_popup()
	popup.add_item("Normal")
	popup.add_item("Hard")
	popup.connect("id_pressed", self, "_on_item_pressed")
	
	if settings._settings.game.difficulty == 0:
		game_difficulty.set_text(popup.get_item_text(0))
	if settings._settings.game.difficulty == 1:
		game_difficulty.set_text(popup.get_item_text(1))
	
	#pass

func _on_item_pressed(ID):
	var pop  = game_difficulty.get_popup()
	#print(pop.get_item_text(ID))
	game_difficulty.set_text(pop.get_item_text(ID))
	print("ID:"+String(ID))
	settings._settings.game.difficulty = ID
	#pass
	
func _on_BtnApply_pressed():
	#settings = get_node("/root/settings")
	#print(settings)
	#print(String(settings._settings.game.username))
	
	settings.save_settings()
	#pass
	

