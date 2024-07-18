extends Area2D
var angle = 0
@export var angle_plusminus = 1
const bullet = preload("res://enemy_bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	pass
	var bullet1 = bullet.instantiate()
	angle += 90.1*angle_plusminus
	bullet1.rotation_degrees = angle
	add_child(bullet1)
	await get_tree().create_timer(0.2).timeout


