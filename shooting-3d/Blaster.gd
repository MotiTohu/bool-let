extends Sprite3D

@export var follow_weight := 10.0
@export var z_offset := 0.01

func _process(delta):
	rotation = rotation.slerp(get_parent().rotation, delta * follow_weight)
	global_position = global_position.slerp(get_parent().global_position,delta * follow_weight)
	global_position.z += z_offset
