extends CollisionShape3D
@onready var sprite_3d = $Sprite3D
var defaultsiz = 5

var progress : float :
	set(v):
		sprite_3d.material_override.set("shader_parameter/progress",v)
var alpha : float :
	set(v):
		sprite_3d.material_override.set("shader_parameter/alpha",v)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	progress = 0
	alpha = 1
	var tw := get_tree().create_tween()
	tw.set_ease(Tween.EASE_IN)
	tw.tween_property(self,"progress",0,0)
	tw.tween_property(self,"alpha",1,0)
	tw.tween_property(self,"progress",1,2)
	tw.tween_property(self,"alpha",1,0)
	tw.tween_property(self,"alpha",0,.5)
	tw.tween_property(self,"alpha",1,.5)
	tw.tween_property(self,"alpha",0,.4)
	tw.tween_property(self,"alpha",1,.4)
	tw.tween_property(self,"alpha",0,.3)
	tw.tween_property(self,"alpha",1,.3)
	tw.tween_property(self,"alpha",0,.2)
	tw.tween_property(self,"alpha",1,.2)
	tw.tween_property(self,"alpha",0,.2)
	tw.play()
	
