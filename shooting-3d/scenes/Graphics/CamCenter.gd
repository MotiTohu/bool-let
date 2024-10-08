extends Node3D


@export var speed := 5.0
@export var weight := 5.0

var delta_sum := .0
var noise := FastNoiseLite.new()

var rotation_degrees_to := Vector3.ZERO
func _process(delta: float) -> void:
	delta_sum += delta * speed
	if CamControl.cam_move:
		rotation_degrees_to.x = noise.get_noise_2d(delta_sum,-delta_sum) * weight
		rotation_degrees_to.y = noise.get_noise_2d(-delta_sum,delta_sum) * weight
	else:
		rotation_degrees_to = Vector3.ZERO
	
	rotation_degrees=rotation_degrees.slerp(rotation_degrees_to,.03)
