class_name MainPlayer extends Charactor

@export_category("movement")
@export var SPEED := 600.0
@export var DEPTH_SPEED := 3.0
@export var ROTATE_SPEED := 3.0
@export var MOVE_DEPTH := 5.0
@export_category("shoot")
@export_enum("1:0","2:1") var shoot_mode := 1

@onready var aiming: RayCast3D = $Aiming
@onready var blaster: Sprite3D = $Blaster

var damaga_able=true
var depth_move_able = 0

var aim_pos : Vector2:
	get:
		var target_pos = global_position
		target_pos.z -= 40.0
		if aiming.is_colliding():
			target_pos = aiming.get_collision_point()
		var cam := get_viewport().get_camera_3d()
		return cam.unproject_position(target_pos)

func _move(delta:float)->void:
	var input_movement := Input.get_vector("left", "right", "down", "up")
	var input_depth := Input.get_axis("back","front")
	if depth_move_able==2:input_depth = 0
	var direction := Vector3(input_movement.x,  input_movement.y,0).normalized()
	if direction:
		velocity.x = direction.x * SPEED * delta
		velocity.y = direction.y * SPEED * delta
	else:
		velocity.x = move_toward(velocity.x,0,SPEED * delta)
		velocity.y = move_toward(velocity.y,0,SPEED * delta)
	velocity.z = (input_depth * MOVE_DEPTH - position.z) * DEPTH_SPEED * (2.0 if input_depth else 1.0)
	# todo export this 
	position.x = clampf(position.x,-8,8)
	position.y = clampf(position.y,-4.5,4.5)
	if input_depth != 0:
		damaga_able = false
		depth_move_able = 1
		await get_tree().create_timer(.3).timeout
		damaga_able = true
		depth_move_able = 2
		await  get_tree().create_timer(1.2).timeout
		depth_move_able = 0

func _rotate(delta:float)->void:
	var rotate_to := -Input.get_axis("left","right") * PI / 6
	rotation.z = lerp_angle(rotation.z,rotate_to,delta * ROTATE_SPEED)

@onready var shoot_interval := $ShootInterval
const BULLET := preload("res://scenes/Charactors/Player/PlayerBullet.tscn")
var shootable := true
func _on_shoot_interval_timeout()->void:shootable=true
func _shoot()->void:
	if Input.is_action_just_pressed("change_shoot_mode"):
		shoot_mode += 1
		shoot_mode %= 2
	if shootable && Input.is_action_pressed("shoot"):
		shootable = false
		if shoot_mode == 0:
			var bullet := BULLET.instantiate()
			add_child(bullet)
			bullet.global_position = global_position
			shoot_interval.start(.1)
		elif shoot_mode == 1:
			var bullet_l := BULLET.instantiate()
			var bullet_r := BULLET.instantiate()
			add_child(bullet_l)
			add_child(bullet_r)
			bullet_l.global_position = global_position
			bullet_r.global_position = global_position
			var bullet_pos := Vector2(.55,0).rotated(rotation.z)
			bullet_pos.x += blaster.global_position.x - global_position.x
			bullet_pos.y += blaster.global_position.y - global_position.y
			bullet_l.position.x -= bullet_pos.x
			bullet_l.position.y -= bullet_pos.y
			bullet_r.position.x += bullet_pos.x
			bullet_r.position.y += bullet_pos.y
			shoot_interval.start(.2)
		UIControl.SCORE -= 3

func _ready() -> void:
	super()
	UIControl.max_player_hp = HP
	UIControl.player_hp = HP

func _physics_process(delta: float) -> void:
	_move(delta)
	_rotate(delta)
	if(UIControl.game_status == UIControl.GAME_STATUS.START):_shoot()
	super(delta)

func _on_on_damage(damage: float) -> void:
	UIControl.player_hp = HP
	UIControl.SCORE -= damage * 100


func _on_player_hp_lost() -> void:
	UIControl.failre_game.emit()
