# Godot Collision
 * Lasted Update: 2018-02-06

# Collision Physics 3D

 There couple of way of collision detects. One is layer and mask. Two groups tag names. Three using the ray cast types. But it depend on the coding the right ways and knowing which works the best. There no wrong and right to handle collision to detect them. It just how much loop to reduce time to detect collision.


```
#simple script shape 
func _physics_process(delta):
    var sphere = SphereShape.new()
    sphere.radius = 1
    var params = PhysicsShapeQueryParameters.new()
    #params.set_shape(sphere)
```


```
#simple body collision from sub collision shape get node
func _physics_process(delta):
    var params = PhysicsShapeQueryParameters.new()
    #simple RigidBody > Collision Shape
    params.set_shape(get_node("CollisionShape").get_shape()) #default name test
```

Notes:
 * CollisionShape Node > get_shape() #work
 * RigidBody Node > get_shape() #fail not a shape
 * Reminder just testing get shape working. To learn how to script here.


Here a simple example test collision shape checks.
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
 * https://github.com/godotengine/godot/issues/14883
 * https://godotengine.org/qa/4010/whats-difference-between-collision-layers-collision-masks
 * https://www.reddit.com/r/godot/comments/7de32n/help_with_collision_masks_and_layers/
 * http://docs.godotengine.org/en/3.0/classes/class_physicsbody.html?highlight=set_collision_mask_bit
 * https://godotengine.org/qa/14724/access-the-shape-get-info-about-the-signal-body_enter_shape
 * https://github.com/godotengine/godot/issues/2089
 * 


# Notes:
 * Took a while to find the correct way to used script collision.
 * Can be found in godot 3 github.