#godot inputs:
 * https://godotengine.org/qa/17381/how-to-use-get_button_index-in-godot-3-0-alpha
 * 


```GDScript
func _input(event):
    if event is InputEventMouseButton:
        if event.button_index == BUTTON_WHEEL_UP:
            print("wheel up!")

```


```
func _input(event):
    if event is InputEventMouseButton: #mouse press
        pass
    if event is InputEventMouseMotion: #mouse move
        pass

```

