extends Node

const SAVE_PATH = "user://config.cfg"

var _config_file = ConfigFile.new()
var _settings = {
	"profile":{
		"username":"guest"
	},
	"game":{
		"language": "english",
		"subtilte": false,
		"difficulty": 0,
		"skipcutscene":true,
		"simplemenu":false
	},
	"audio":{
		#"mute": Globals.get("Settings/mute")
		"master":4.5,
		"musics":4.5,
		"effects":4.5,
		"voice":4.5
	},
	"debug":{
		"vector_color" : Color(1.0,1.0,0.0),
		"area_color" : Color(0.0,1.0,0.2,0.5)
	}
}

func _ready():
	var error = _config_file.load(SAVE_PATH)
	if error != OK: #if no file create and save
		print("create config!")
		save_settings()
	load_settings()
	#print(_settings)
	#pass

func save_settings():
	for section in _settings.keys():
		for key in _settings[section].keys():
			_config_file.set_value(section, key,_settings[section][key])
	_config_file.save(SAVE_PATH)
	
func load_settings():
	var error = _config_file.load(SAVE_PATH)
	if error != OK:
		print("Error loading the settings. Error code %s" % error)
		return []
		
	var values = []
	for section in _settings.keys():
		for key in _settings[section].keys():
			var val = _settings[section][key]
			#values.append(_config_file.get_value(section,key,val))
			_settings[section][key] = _config_file.get_value(section,key,null)
			#print("%s: %s" % [key, val])
	#return values

func get_settings():
	return _settings