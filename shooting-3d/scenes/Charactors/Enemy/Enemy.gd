class_name Enemy extends Charactor

@export var offset := Vector3.ZERO
@onready var behavior_timer: Timer = $BehaviorTimer
@onready var shot_timer: Timer = $ShotTimer


const _3X3_BULLET = preload("res://scenes/Charactors/Enemy/Bullets/3x3Bullet.tscn")
const ENEMY_BULLET = preload("res://scenes/Charactors/Enemy/Bullets/EnemyBullet.tscn")
var bullets :Array[PackedScene] = [ENEMY_BULLET,_3X3_BULLET]
var shotable := true
signal on_shotable

func _ready() -> void:
	super()
	
func shot(i:int,interval:float = -1)->void:
	if(UIControl.game_status == UIControl.GAME_STATUS.START):
		shotable = false
		var bullet :Bullet= bullets[i].instantiate()
		get_parent().add_child(bullet)
		bullet.global_position = global_position
		shot_timer.start(interval)

func _on_shot_timer_timeout() -> void:
	shotable = true


func _on_enemy_damage(damage: float) -> void:
	UIControl.SCORE += damage * 100
