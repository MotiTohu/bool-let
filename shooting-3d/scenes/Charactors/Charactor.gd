class_name Charactor extends CharacterBody3D 

@export var HP := 100.0

func decrease_hp(diff:float)->void:
	HP -= diff

func check_is_bullet(col:Bullet) -> bool:
	return true

func check_damage():
	for i in get_slide_collision_count():
		var col :Object= get_slide_collision(i).get_collider()
		if col is Bullet:
			decrease_hp(col.DAMAGE)
			col.queue_free()

func _physics_process(delta: float) -> void:
	check_damage()
