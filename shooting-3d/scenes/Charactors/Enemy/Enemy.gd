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
	UIControl.start_game.connect(reset_bullet)
	UIControl.reset_game.connect(reset_bullet)
	UIControl.failre_game.connect(reset_bullet)
	UIControl.clear_game.connect(reset_bullet)
	
func reset_bullet()->void:
	for i in get_parent().get_children():
			if i is Bullet:
				i.queue_free()
func shot(i:int,interval:float = -1)->void:
	shotable = false
	var bullet :Bullet= bullets[i].instantiate()
	get_parent().add_child(bullet)
	bullet.global_position = global_position
	shot_timer.start(interval)

func _on_shot_timer_timeout() -> void:
	shotable = true

func _on_on_hp_lost() -> void:
	queue_free()


func _on_enemy_damage(damage: float) -> void:
	UIControl.SCORE += damage * 100
