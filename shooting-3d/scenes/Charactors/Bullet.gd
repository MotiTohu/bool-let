class_name Bullet extends Area3D 

@export var MOVE_TO := Vector3(0, 0, 1)
@export var SPEED := 200.0
@export var DEL_POS := 0.0
@export var DAMAGE := 1.0

const EFFECT := preload("res://scenes/Graphics/effect_playerhit.tscn")

func _ready() -> void:
	MOVE_TO = MOVE_TO.normalized()
	UIControl.start_game.connect(queue_free)
	UIControl.clear_game.connect(queue_free)
	UIControl.reset_game.connect(queue_free)
	UIControl.failre_game.connect(queue_free)

func _physics_process(delta: float) -> void:
	position += MOVE_TO * SPEED * delta
	if DEL_POS != 0 &&  position.z < -DEL_POS:
		queue_free()

func _on_visible_on_screen_notifier_3d_screen_exited() -> void:
	queue_free()


func _on_body_entered(body: Node3D) -> void:
	if body is Charactor:
		if body is not Enemy:
			if ! body.damaga_able:
				queue_free()
		body.decrease_hp(DAMAGE)
		if body is Enemy:
			var effect := EFFECT.instantiate()
			body.add_child(effect)
			effect.global_position = global_position
			effect.rotation.z = randf_range(0,2.0)*PI
			
		queue_free()
