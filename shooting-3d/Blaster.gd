extends Sprite3D

@export var follow_weight := 30.0
@export var z_offset := 0.02
@export_category("float")
@export var float_speed := 1.0
@export var float_weight := 50.0

var delta_sum := 0.0
func _process(delta):
	rotation.z = lerpf(rotation.z,get_parent().rotation.z,delta * follow_weight)
	global_position = global_position.slerp(get_parent().global_position,delta * follow_weight)
	global_position.z += z_offset
	
	delta_sum += delta * float_speed
	delta_sum = fmod(delta_sum,PI*2)
	offset.y = sin(delta_sum) * float_weight
