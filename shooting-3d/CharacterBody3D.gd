extends CharacterBody3D


const SPEED := 300.0
const DEPTH_SPEED := 3.0


func _physics_process(delta):
	var input_movement := Input.get_vector("left", "right", "down", "up")
	var input_depth := Input.get_axis("back","front")
	var direction = (transform.basis * Vector3(input_movement.x,  input_movement.y,0)).normalized()
	if direction:
		velocity.x = direction.x * SPEED * delta
		velocity.y = direction.y * SPEED * delta
	else:
		velocity.x = move_toward(velocity.x,0,SPEED * delta)
		velocity.y = move_toward(velocity.y,0,SPEED * delta)
	velocity.z = (input_depth - position.z) * DEPTH_SPEED * (2.0 if input_depth else 1.0)
	
	move_and_slide()
	position.x = clampf(position.x,-3,3)
	position.y = clampf(position.y,-3,3)
