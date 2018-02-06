extends AnimatedSprite

var tempElapsed = 0

#http://www.gamefromscratch.com/post/2015/06/03/Godot-Engine-Tutorial-Part-9-Sprite-Animation.aspx

func _ready():
	set_process(true)
   
func _process(delta):
	tempElapsed = tempElapsed + delta
	if(tempElapsed > 0.1):
		if(get_frame() == self.get_sprite_frames().get_frame_count()-1):
			set_frame(0)
		else:
			self.set_frame(get_frame() + 1)
		tempElapsed = 0
	print(str(get_frame() + 1))