# godot ray cast

 * http://docs.godotengine.org/en/3.0/tutorials/physics/ray-casting.html?highlight=intersect_ray
 * http://docs.godotengine.org/en/3.0/classes/class_raycast.html?highlight=layer%20mask
 * http://docs.godotengine.org/en/3.0/tutorials/physics/ray-casting.html?highlight=spacestate
 * https://github.com/godotengine/godot/issues/2217
 * http://www.gamefromscratch.com/post/2015/12/08/Godot-Engine-Tutorial-Part-17-3D-Ray-casting.aspx
 * https://github.com/godotengine/godot/issues/2217

 * https://github.com/godotengine/godot/issues/1725



# ray cast without plane mesh and y axis zero plane
```
var camera = self #get_node("Camera")
var view = camera.project_ray_normal(ev.position) #convert 2D mouse position to vector3.
var dir = view.normalized()
var distance = - camera.transform.origin.y / dir.y; #Change axis to any x,y,z
var pos = Vector3(camera.transform.origin.x,camera.transform.origin.y,camera.transform.origin.z) + dir * distance #convert to plane zero y axis to zero
```

# ray cast hit
```
var ray_length = 10

var camera = self #get_node("Camera")
var from = camera.project_ray_origin(ev.position)
var to = from + camera.project_ray_normal(ev.position) * ray_length

var directState = PhysicsServer.space_get_direct_state(camera.get_world().get_space())
var result = directState.intersect_ray(from, to, [self])

if result.size() != 0:
    print("Hit")
    pass
```