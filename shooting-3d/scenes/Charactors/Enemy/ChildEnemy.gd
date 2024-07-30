extends Enemy
class_name ChildEnemy 

var hp := 10.0
func decrease_hp(diff_value:float)->void:
	hp -= diff_value
	if hp <= 0.0:
		queue_free()
