extends Area2D
var angle = 0
@export var angle_plusminus = 1
const bullet = preload("res://enemy_bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var bullet1 = bullet.instantiate()
	angle += 20*angle_plusminus
	bullet1.rotation_degrees = angle
	add_child(bullet1)

func _on_timer_timeout():
	queue_free
