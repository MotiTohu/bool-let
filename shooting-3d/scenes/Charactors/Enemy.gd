class_name Enemy extends Charactor

@export var behavior : Array[EnemyBehavior] = []
@export var offset := Vector3.ZERO 
var current_behavior := 0
@onready var behavior_timer: Timer = $BehaviorTimer


func behave(i:int)->void:
	if behavior[i].next < 0:
		current_behavior -= behavior[i].next
		current_behavior = current_behavior % behavior.size()
	else:
		current_behavior = behavior[i].next
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
