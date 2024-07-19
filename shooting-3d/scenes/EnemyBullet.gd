extends CharacterBody3D

@export var SPEED := 600.0

func _physics_process(delta:float)->void:
	for i in get_slide_collision_count():
		var col := get_slide_collision(i).get_collider()
		if col is Player:
			print("DAMAGE!")
			queue_free()
	velocity.z = SPEED * delta
	move_and_slide()


func _on_visible_on_screen_notifier_3d_screen_exited() -> void:
		queue_free()
