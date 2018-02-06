# Godot Collision
 * Lasted Update: 2018-02-06

# Collision Physics 3D

```
var excludes = []

func _ready():
    # http://docs.godotengine.org/en/stable/classes/class_rid.html?highlight=rid
	print("get_rid:",get_rid())
	excludes.append(get_rid())
	pass

func _physics_process(delta):
    var sphere = SphereShape.new()
	sphere.radius = 1
	var params = PhysicsShapeQueryParameters.new()
	params.set_shape(sphere)

    params.set_transform(get_transform())  #update position object
    params.set_exclude(excludes) # here exclude is an array of... RID

    var state = get_world().get_direct_space_state()
	var results = state.intersect_shape(params, 2)

    if results.size() != 0:
        print(results[0])
        if results[0].collider.get_name() == get_name():
            print("found!")

```

# Links:
 * https://github.com/godotengine/godot/issues/2217

# Notes:
 * Took a while to find the correct way to used script collision.
 * Can be found in godot 3 github.