extends  Bullet

var player : MainPlayer
func _ready() -> void:
	player = get_viewport().get_child(0).find_child("Player")
	MOVE_TO = Vector3(randf_range(-1,1),randf_range(-1,1),.5).normalized()
	look_at(MOVE_TO,Vector3(0,0,1))


var _move_to : Vector3
func _physics_process(delta: float) -> void:
	_move_to = global_position.direction_to(player.global_position).normalized()
	MOVE_TO = (_move_to - MOVE_TO) * .1 + MOVE_TO
	MOVE_TO.z = min(max(MOVE_TO.z,1),2)
	MOVE_TO = MOVE_TO.normalized()
	look_at(MOVE_TO+global_position)
	super(delta)
	

func _on_any_entered(body: Node3D) -> void:
	if body is Bullet:

		print("bullet hits ")
