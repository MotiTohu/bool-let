class_name Charactor extends CharacterBody3D 

@export var HP := 100.0
signal on_hp_lost
signal on_damage(damage:float)

func decrease_hp(diff:float)->void:
	HP -= diff
	if HP < 0:
		on_hp_lost.emit()
		return
	else:
		on_damage.emit(diff)

func check_is_bullet(_col:Bullet) -> bool:
	return true

func _physics_process(_delta: float) -> void:
	move_and_slide()
