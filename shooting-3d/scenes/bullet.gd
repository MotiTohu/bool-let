extends Area3D

@export var SPEED := 20.0
@export var DEL_POS := 1000.0

func _physics_process(delta):
	position.z -= SPEED * delta
	if position.z < -DEL_POS:
		queue_free()
