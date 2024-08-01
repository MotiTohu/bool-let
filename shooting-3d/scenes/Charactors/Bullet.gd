class_name Bullet extends Area3D 

@export var MOVE_TO := Vector3(0, 0, 1)
@export var SPEED := 200.0
@export var DEL_POS := 0.0
@export var DAMAGE := 1.0

func _ready() -> void:
	MOVE_TO = MOVE_TO.normalized()

func _physics_process(delta: float) -> void:
	position += MOVE_TO * SPEED * delta
	if DEL_POS != 0 &&  position.z < -DEL_POS:
		queue_free()

func _on_visible_on_screen_notifier_3d_screen_exited() -> void:
	queue_free()


func _on_body_entered(body: Node3D) -> void:
	if body is Charactor:
		body.decrease_hp(DAMAGE)
		queue_free()
