extends Area2D
var angle = 0
const bullet = preload("res://enemy_bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func firing():
	angle = 0
	for i in range(18):
		var enemy_bullet1 = bullet.instantiate()
		angle += 20
		enemy_bullet1.rotation_degrees = angle
		add_child(enemy_bullet1)


func _on_timer_timeout():
	firing()
