extends RigidBody3D
class_name Enemy

var delta_sum := 0.0

func _process(delta: float) -> void:
	delta_sum += delta
	delta_sum = fmod(delta_sum,PI*2)
	var to := Vector2.from_angle(delta_sum) * 5
	position.x = to.x
	position.y = to.y



func _on_body_entered(body: Node) -> void:
	print(body)
