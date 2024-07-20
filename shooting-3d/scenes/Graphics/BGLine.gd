extends CSGCylinder3D

@export var SPEED := 400.0
func _process(delta:float)->void:
	position.z += delta * SPEED

func _on_visible_on_screen_notifier_3d_screen_exited()->void:
	queue_free()
