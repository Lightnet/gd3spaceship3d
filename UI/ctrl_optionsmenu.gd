extends Control

var settings

var game_difficulty
var popup

var silder_audio_master
var spin_audio_master

var silder_audio_music
var spin_audio_music

var silder_audio_effects
var spin_audio_effects

var silder_audio_voice
var spin_audio_voice

func _on_Button_pressed():
	hide()
	get_parent().get_node("ctrl_mainmenu").show()
	
func _ready():
	settings = get_node("/root/settings")
	
	# Game settings
	
	game_difficulty = get_node("Panel/TabContainer/Game/VScrollBar/VBoxContainer/HBoxContainer_Game/MenuButton")
	popup = game_difficulty.get_popup()
	popup.add_item("Normal")
	popup.add_item("Hard")
	popup.connect("id_pressed", self, "_on_item_pressed")
	
	if settings._settings.game.difficulty == 0:
		game_difficulty.set_text(popup.get_item_text(0))
	if settings._settings.game.difficulty == 1:
		game_difficulty.set_text(popup.get_item_text(1))
			
	var btn_subtitle = get_node("Panel/TabContainer/Game/VScrollBar/VBoxContainer/HBoxContainer_subtitle/CheckButton_Subtitle")
	btn_subtitle.set_pressed(settings._settings.game.subtilte)
	
	var btn_skipcutscene = get_node("Panel/TabContainer/Game/VScrollBar/VBoxContainer/HBoxContainer_skipscene/CheckButton_SkipCutScene")
	btn_skipcutscene.set_pressed(settings._settings.game.skipcutscene)
	
	var btn_simplemenu = get_node("Panel/TabContainer/Game/VScrollBar/VBoxContainer/HBoxContainer_simplemenu/CheckButton_SimpleMenu")
	btn_simplemenu.set_pressed(settings._settings.game.simplemenu)
	
	# Audio settings
	
	silder_audio_master = get_node("Panel/TabContainer/Audio/VScrollBar2/VBoxContainer/HBoxContainer/Svolumecontrol_Master")
	spin_audio_master = get_node("Panel/TabContainer/Audio/VScrollBar2/VBoxContainer/HBoxContainer/SpinBox_Master")
	
	silder_audio_master.value = settings._settings.audio.master
	spin_audio_master.value = settings._settings.audio.master
	
	silder_audio_music = get_node("Panel/TabContainer/Audio/VScrollBar2/VBoxContainer/HBoxContainer2/Svolumecontrol_Music")
	spin_audio_music = get_node("Panel/TabContainer/Audio/VScrollBar2/VBoxContainer/HBoxContainer2/SpinBox_Music")
	
	silder_audio_music.value = settings._settings.audio.musics
	spin_audio_music.value = settings._settings.audio.musics
	
	silder_audio_effects = get_node("Panel/TabContainer/Audio/VScrollBar2/VBoxContainer/HBoxContainer3/Svolumecontrol_Effects")
	spin_audio_effects = get_node("Panel/TabContainer/Audio/VScrollBar2/VBoxContainer/HBoxContainer3/SpinBox_Effects")
	
	silder_audio_effects.value = settings._settings.audio.effects
	spin_audio_effects.value = settings._settings.audio.effects
	
	silder_audio_voice = get_node("Panel/TabContainer/Audio/VScrollBar2/VBoxContainer/HBoxContainer4/Svolumecontrol_Voice")
	spin_audio_voice = get_node("Panel/TabContainer/Audio/VScrollBar2/VBoxContainer/HBoxContainer4/SpinBox_Voice")
	
	silder_audio_voice.value = settings._settings.audio.voice
	spin_audio_voice.value = settings._settings.audio.voice
	
	# input 
	
	
	
	
	#pass

func _on_item_pressed(ID):
	var pop  = game_difficulty.get_popup()
	#print(pop.get_item_text(ID))
	#print("ID:"+String(ID))
	game_difficulty.set_text(pop.get_item_text(ID))
	settings._settings.game.difficulty = ID
	
func _on_BtnApply_pressed():
	#settings = get_node("/root/settings")
	#print(settings)
	#print(String(settings._settings.game.username))
	#settings._settings.audio.master = silder_audio_master.value
	#settings._settings.audio.musics = silder_audio_music.value 
	#settings._settings.audio.effects = silder_audio_effects.value
	#settings._settings.audio.voice = silder_audio_voice.value 
	
	settings._settings.audio.master = AudioServer.get_bus_volume_db(0)
	settings._settings.audio.musics = AudioServer.get_bus_volume_db(1)
	settings._settings.audio.effects = AudioServer.get_bus_volume_db(2)
	settings._settings.audio.voice = AudioServer.get_bus_volume_db(3)
	
	settings.save_settings()
	#pass

func _on_CheckButton_Subtitle_toggled( button_pressed ):
	#print("button" + String(button_pressed))
	settings._settings.game.subtilte = button_pressed

func _on_CheckButton_SkipCutScene_toggled( button_pressed ):
	settings._settings.game.skipcutscene = button_pressed

func _on_CheckButton_SimpleMenu_toggled( button_pressed ):
	settings._settings.game.simplemenu = button_pressed
	
func _on_SpinBox_Master_value_changed( value ):
	silder_audio_master.value = value
	AudioServer.set_bus_volume_db(0,value)
func _on_Svolumecontrol_Master_value_changed( value ):
	spin_audio_master.value = value
	AudioServer.set_bus_volume_db(0,value)
func _on_Svolumecontrol_Music_value_changed( value ):
	spin_audio_music.value = value
	AudioServer.set_bus_volume_db(1,value)
func _on_SpinBox_Music_value_changed( value ):
	silder_audio_music.value = value
	AudioServer.set_bus_volume_db(1,value)
func _on_Svolumecontrol_Effects_value_changed( value ):
	spin_audio_effects.value = value
	AudioServer.set_bus_volume_db(2,value)
func _on_SpinBox_Effects_value_changed( value ):
	silder_audio_effects.value = value
	AudioServer.set_bus_volume_db(2,value)
func _on_Svolumecontrol_Voice_value_changed( value ):
	spin_audio_voice.value = value
	AudioServer.set_bus_volume_db(3,value)
func _on_SpinBox_Voice_value_changed( value ):
	silder_audio_voice.value = value
	AudioServer.set_bus_volume_db(3,value)
