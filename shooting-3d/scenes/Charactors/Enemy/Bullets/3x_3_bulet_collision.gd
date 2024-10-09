extends CollisionShape3D
@onready var sprite_3d = $Sprite3D
var defaultsiz = 5

var progress : float :
	set(v):
		sprite_3d.material_override.set("shader_parameter/progress",v)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	progress = 5
	var tw := get_tree().create_tween()
	tw.tween_property(self,"progress",1,4)
	tw.play()
	
