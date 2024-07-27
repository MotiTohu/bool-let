extends StaticBody3D
class_name Enemy

@onready var ui: = %UI

@export var SPEED :float = 1.0
@export var offset: Vector2 = Vector2.ZERO
@export var xy_range :float = 5.0
@export var z_range :float = 10.0

var delta_sum := 0.0

func _process(delta: float) -> void:
	delta_sum += delta * SPEED
	delta_sum = fmod(delta_sum,PI*2)
	var to := Vector2.from_angle(delta_sum) * xy_range
	position.x = to.x + offset.x
	position.y = to.y + offset.y
	position.z = -40 + sin(delta_sum * 2) * z_range

const ENEMY_BULLET = preload("res://scenes/Charactors/Enemy/EnemyBullet.tscn")
func _on_timer_timeout() -> void:
	var bullet := ENEMY_BULLET.instantiate()
	add_child(bullet)

func decrease_hp(diff_value:float)->void:
	ui.EnemyHP -= diff_value

const CHILD_ENEMY = preload("res://scenes/Charactors/Enemy/ChildEnemy.tscn")
func _on_child_timeout() -> void:
	var child := CHILD_ENEMY.instantiate()
	child.offset = Vector2(position.x,position.y)
	add_child(child)
