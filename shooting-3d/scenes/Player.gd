extends CharacterBody3D
class_name Player

@export_category("movement")
@export var SPEED := 600.0
@export var DEPTH_SPEED := 3.0
@export var ROTATE_SPEED := 3.0
@export var MOVE_DEPTH := 5.0
@export_category("shoot")
@export_enum("1:0","2:1") var shoot_mode := 1

@onready var node_3d := $Node3D
@onready var collision_shape_3d := $CollisionShape3D
@onready var aim := $Aim
@onready var blaster := $Node3D/Blaster
@onready var ray_cast_3d := $RayCast3D


var aim_pos : Vector2:
	get:
		var target_pos = aim.global_position
		if ray_cast_3d.is_colliding():
			target_pos = ray_cast_3d.get_collision_point()
		var cam := get_viewport().get_camera_3d()
		return cam.unproject_position(target_pos)

func _move(delta:float)->void:
	var input_movement := Input.get_vector("left", "right", "down", "up")
	var input_depth := Input.get_axis("back","front")
	var direction := (transform.basis * Vector3(input_movement.x,  input_movement.y,0)).normalized()
	if direction:
		velocity.x = direction.x * SPEED * delta
		velocity.y = direction.y * SPEED * delta
	else:
		velocity.x = move_toward(velocity.x,0,SPEED * delta)
		velocity.y = move_toward(velocity.y,0,SPEED * delta)
	velocity.z = (input_depth * MOVE_DEPTH - position.z) * DEPTH_SPEED * (2.0 if input_depth else 1.0)
	move_and_slide()
	position.x = clampf(position.x,-8,8)
	position.y = clampf(position.y,-6,6)

func _rotate(delta:float)->void:
	var rotate_to := -Input.get_axis("left","right") * PI / 6
	collision_shape_3d.rotation.z = lerp_angle(collision_shape_3d.rotation.z,rotate_to,delta * ROTATE_SPEED)
	node_3d.rotation = collision_shape_3d.rotation

@onready var shoot_interval := $ShootInterval
const BULLET := preload("res://scenes/Bullet.tscn")
var shootable := true
func _on_shoot_interval_timeout()->void:shootable=true
func _shoot():
	if Input.is_action_just_pressed("change_shoot_mode"):
		shoot_mode += 1
		shoot_mode %= 2
	if shootable && Input.is_action_pressed("shoot"):
		shootable = false
		if shoot_mode == 0:
			var bullet := BULLET.instantiate()
			add_child(bullet)
			shoot_interval.start(.1)
		elif shoot_mode == 1:
			var bullet_l := BULLET.instantiate()
			var bullet_r := BULLET.instantiate()
			var bullet_pos := Vector2(.55,0).rotated(node_3d.rotation.z)
			bullet_pos.x += blaster.global_position.x - node_3d.global_position.x
			bullet_pos.y += blaster.global_position.y - node_3d.global_position.y
			bullet_l.position.x -= bullet_pos.x
			bullet_l.position.y -= bullet_pos.y
			bullet_r.position.x += bullet_pos.x
			bullet_r.position.y += bullet_pos.y
			add_child(bullet_l)
			add_child(bullet_r)
			shoot_interval.start(.2)
		
func _physics_process(delta:float)->void:
	_move(delta)
	_rotate(delta)
	_shoot()

