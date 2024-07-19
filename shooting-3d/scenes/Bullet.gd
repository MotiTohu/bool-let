extends CharacterBody3D

@export var SPEED := 6000.0
@export var DEL_POS := 200.0

func _physics_process(delta:float)->void:
	for i in get_slide_collision_count():
		var col := get_slide_collision(i).get_collider()
		if col is Enemy:
			print("HIT!")
	velocity.z = -SPEED * delta
	move_and_slide()
	if position.z < -DEL_POS:
		queue_free()
