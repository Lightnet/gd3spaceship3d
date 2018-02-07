#godot inputs:
 * https://godotengine.org/qa/17381/how-to-use-get_button_index-in-godot-3-0-alpha
 * http://docs.godotengine.org/en/stable/learning/features/gui/custom_gui_controls.html?highlight=button_left
 * 

```
func _input(ev):
    if ev.pressed:
        pass
    if !ev.is_pressed(): # false > release
        pass
    if ev.is_pressed(): # true > press
        pass
```



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

