extends Control

var ctrl_Campaign = load("res://UI/ctrl_campaignmenu.tscn")
var CampaignMenu

var ctrl_Training = load("res://UI/ctrl_trainingmenu.tscn")
var TrainingMenu

var ctrl_Multiplayers = load("res://UI/ctrl_multiplayersmenu.tscn")
var MultiplayersMenu

var ctrl_Options = load("res://UI/ctrl_optionsmenu.tscn")
var OptionsMenu


func _ready():
	
	pass

func _input(event):
	
	pass
	
func _checkmenu(path, objclass, value):
	if value == null:
		value = objclass.instance()
		value.show()
		get_parent().add_child(value)
	else:
		value = get_node(path)
		value.show()
	hide()

func _on_BtnCampiagn_pressed():
	_checkmenu("../ctrl_campaignmenu", ctrl_Campaign, CampaignMenu)
	
func _on_BtnTraining_pressed():
	_checkmenu("../ctrl_trainingmenu", ctrl_Training, TrainingMenu)
	
func _on_BtnMultiplayers_pressed():
	_checkmenu("../ctrl_multiplayersmenu", ctrl_Multiplayers, MultiplayersMenu)
	
func _on_BtnOptions_pressed():
	_checkmenu("../ctrl_optionsmenu", ctrl_Options, OptionsMenu)
func _on_BtnQuit_pressed():
	get_tree().quit()
	pass
