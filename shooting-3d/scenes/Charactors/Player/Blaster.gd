extends Sprite3D

@export var follow_weight := 10.0
@export var z_offset := 0.2
@export_category("float")
@export var float_speed := 1.0
@export var float_weight := 50.0

var delta_sum := 0.0
func _physics_process(delta:float)->void:
	rotation.z += (get_parent().rotation.z - rotation.z) * delta * follow_weight 
	var to = get_parent().global_position - global_position
	to.z -= z_offset
	to.z *= 3
	global_position += to * delta * follow_weight
	
	delta_sum = fmod(delta_sum + delta * float_speed,PI*2)
	offset.y = sin(delta_sum) * float_weight
