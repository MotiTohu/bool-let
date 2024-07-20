extends StaticBody3D
class_name Enemy

var delta_sum := 0.0

func _process(delta: float) -> void:
	delta_sum += delta
	delta_sum = fmod(delta_sum,PI*2)
	var to := Vector2.from_angle(delta_sum) * 5
	position.x = to.x
	position.y = to.y
	position.z = -40 + sin(delta_sum * 2) * 10

const ENEMY_BULLET = preload("res://scenes/EnemyBullet.tscn")
func _on_timer_timeout() -> void:
	var bullet := ENEMY_BULLET.instantiate()
	add_child(bullet)
