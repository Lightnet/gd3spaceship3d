# godot audio

Information: Note this is base on what I have tested. The min volume value is -70 and max volume base on limited of my headphone is 10. Working on the scripting side to know how to control those volume levels.

The global access function class is AudioServer.

```
# set bus index and volume value
AudioServer.set_bus_volume_db(0,value)#master bus

# get bus index volume
AudioServer.get_bus_volume_db(0)) 

```

# Links:
 * http://docs.godotengine.org/en/3.0/tutorials/audio/audio_buses.html
 * http://docs.godotengine.org/en/3.0/classes/class_audioserver.html?highlight=set_bus_volume_db