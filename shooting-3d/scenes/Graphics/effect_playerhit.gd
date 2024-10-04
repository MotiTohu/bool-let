extends AnimatedSprite3D

func _ready() -> void:
	play("hit")
	print("hit")

func _on_animation_finished():
	print("hit")
	queue_free()
