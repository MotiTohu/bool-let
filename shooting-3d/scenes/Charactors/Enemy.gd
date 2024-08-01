class_name Enemy extends Charactor

@export var behavior : Array[EnemyBehavior] = []
@export var offset := Vector3.ZERO 
var current_behavior := 0
@onready var behavior_timer: Timer = $BehaviorTimer
@onready var shot_timer: Timer = $ShotTimer


func behave(i:int)->void:
	shot_timer.stop()
	if behavior[i].next < 0:
		current_behavior -= behavior[i].next
		current_behavior = current_behavior % behavior.size()
	else:
		current_behavior = behavior[i].next
	if behavior[i].shot:
		shot_timer.wait_time = behavior[i].shot.interval
		shot_timer.start()
	behavior_timer.start(behavior[i].duration)

func _ready() -> void:
	if behavior.size() > 0:
		behave(0)

func _physics_process(delta: float) -> void:
	if behavior[current_behavior].move:
		velocity = behavior[current_behavior].move.move(delta) + offset - position
		
	super(delta)

func _on_behavior_timer_timeout() -> void:
	behave(current_behavior)

func _on_on_hp_lost() -> void:
	queue_free()

const ENEMY_BULLET = preload("res://scenes/Charactors/Enemy/EnemyBullet.tscn")
func _on_shot_timer_timeout() -> void:
	if behavior[current_behavior].shot:
		var bullet := ENEMY_BULLET.instantiate()
		add_child(bullet)
