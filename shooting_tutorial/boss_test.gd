extends Area2D
var angle = 0
const bullet = preload("res://enemy_bullet.tscn")
const missile = preload("res://homing_missile.tscn")
@onready var player := $"/root/Main/player"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func cutoffr():
	angle = 0
	for i in range(6):
		var enemy_bullet1 = bullet.instantiate()
		enemy_bullet1.rotation_degrees = angle
		add_child(enemy_bullet1)
		angle += 20
		await get_tree().create_timer(0.1).timeout
		
func cutoffl():
	angle = 180
	for i in range(6):
		var enemy_bullet1 = bullet.instantiate()
		enemy_bullet1.rotation_degrees = angle
		add_child(enemy_bullet1)
		angle -= 20
		await get_tree().create_timer(0.1).timeout
		
func shootforp():
	for i in range(10):
		for j in range(-6, 7, 6):
			var enemy_bullet1 = bullet.instantiate()
			add_child(enemy_bullet1)
			angle = enemy_bullet1.global_position.angle_to_point(player.global_position)*180/PI + j
			enemy_bullet1.rotation_degrees = angle
			#print(angle)
		await get_tree().create_timer(0.3).timeout
		
func shootforp2():
	angle = global_position.angle_to_point(player.global_position)
	for i in range(5):
		for j in range(-12, 13, 12):
			var enemy_bullet1 = bullet.instantiate()
			var angle_temp
			add_child(enemy_bullet1)
			angle_temp = angle*180/PI + j
			enemy_bullet1.rotation_degrees = angle_temp
			#print(angle)
		await get_tree().create_timer(0.1).timeout

func homing_missile():
	var homing_missile1 = missile.instantiate()
	angle = global_position.angle_to_point(player.global_position)
	homing_missile1.rotation_degrees = angle
	add_child(homing_missile1)

func _on_timer_timeout():
	#pass
	homing_missile()


func _on_timer_2_timeout():
	shootforp2()
