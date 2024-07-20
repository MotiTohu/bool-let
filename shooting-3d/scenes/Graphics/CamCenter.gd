extends Node3D


@export var speed := 5.0
@export var weight := 5.0

var delta_sum := .0
var noise := FastNoiseLite.new()

func _process(delta: float) -> void:
	delta_sum += delta * speed
	rotation_degrees.x = noise.get_noise_2d(delta_sum,-delta_sum) * weight
	rotation_degrees.y = noise.get_noise_2d(-delta_sum,delta_sum) * weight

