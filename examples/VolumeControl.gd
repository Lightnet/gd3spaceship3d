extends Control

func _ready():
	print("Volume:" + String( AudioServer.get_bus_volume_db(0)) )
	pass

func _on_HSlider_value_changed( value ):
	print("Volume:" + String(value))
	AudioServer.set_bus_volume_db(0,value)#master bus
	pass
