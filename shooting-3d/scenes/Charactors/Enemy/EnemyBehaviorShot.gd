class_name EnemyBehaviorShot extends Resource

@export_enum("nomal","missile") var bullet_mode : int
@export var max_count : int = -1
@export var interval : float = .1

const ENEMY_BULLET = preload("res://scenes/Charactors/Enemy/EnemyBullet.tscn")
var bullet: Bullet:
	get:
		return ENEMY_BULLET.instantiate()
