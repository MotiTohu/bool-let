extends AnimatedSprite3D

func _ready() -> void:
	play()
	#print("hit")

func _on_animation_finished():
	queue_free()
