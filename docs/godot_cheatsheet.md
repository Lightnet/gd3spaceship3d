#Godot Cheat Sheet


# Math
var vec = Vector3()

# Node

```
get_rid() #Node Id
transform.origin #position
get_global_transform() # 
get_global_transform().origin # Position
get_name() # Node Name


```

# Physics
```
var excludes = []

func _ready():
    excludes.append(get_rid()) #Get Current Owner for Physics from RigidBody Id

#Object Shape
var sphere = SphereShape.new()

# get Physics state
var state = get_world().get_direct_space_state()

# collision checks
var params = PhysicsShapeQueryParameters.new()
params.set_shape(sphere)
params.set_transform(get_transform().translated(transform.origin)) # same transform as parent, just translate
params.set_transform(get_transform()) #Current Object Transform Position
params.set_exclude(excludes) # here exclude is an array of... RID (Object IDs)

var results = state.intersect_shape(params, 2)

if results.size() != 0:
    print(results[0])
    print(results[0].collider.get_name())

```

# CollisionShape
```
get_shape() # note it be CollisionShape Node to get shape for intersect_shape func to work.
```





# Input:


```
func _input(event):
    if event is InputEventMouseMotion:
        pass
    if event is InputEventMouseButton:
        if event.button_index == BUTTON_WHEEL_UP:

```