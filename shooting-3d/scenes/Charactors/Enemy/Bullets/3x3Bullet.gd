extends Bullet

@export var move_delay_time := 4.0
@onready var move_delay_timer: Timer = $MoveDelayTimer
const _3X3_BULET_COLLISION = preload("res://scenes/Charactors/Enemy/Bullets/3x3BuletCollision.tscn")
var _speed := 0.0

func _ready() -> void:
	super()
	move_delay_timer.wait_time = move_delay_time
	move_delay_timer.start()
	_speed = SPEED
	SPEED = 0.0
	var used :Array[int] = []
	var cnt := randi_range(3,6)
	for i in cnt:
		var j := randi_range(0,9)
		while j in used:
			j = randi_range(0,9)
		used.append(j)
		var pos := Vector2(j/3-1,j%3-1) * Vector2(16,9) / 3.0
		var col := _3X3_BULET_COLLISION.instantiate()
		add_child(col)
		col.global_position.x = pos.x
		col.global_position.y = pos.y
		col.global_position.z = global_position.z
		col.get_child(0).global_position.x = pos.x
		col.get_child(0).global_position.y = pos.y
		col.get_child(0).global_position.z = 0
	print(cnt,used)

func _on_move_delay_timer_timeout() -> void:
	SPEED = _speed
	global_position.x = 0
	global_position.y = 0
