extends CSGCylinder3D

func _process(delta:float)->void:
	position.z += delta * 200

func _on_visible_on_screen_notifier_3d_screen_exited()->void:
	queue_free()
