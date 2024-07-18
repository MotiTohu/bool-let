extends Area2D
@export var speed = 100
@export var rotationdeg = 20
var angle:float
var velocity:Vector2
@onready var tween = get_tree().create_tween()
@onready var player := $"/root/Main/player"
var lastangle = 180


# Called when the node enters the scene tree for the first time.
func _ready():
	rotation = PI/2.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotation = fmod(rotation,PI*2)
	var angle = global_position.angle_to_point(player.global_position)
	if angle - rotation > PI:
		angle -= PI * 2
	if angle - rotation < -PI:
		angle += PI * 2
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(self,"rotation", angle - rotation,2).as_relative()
	tween.play()
#	var temp_angle = global_position.angle_to_point(player.global_position)
#	var angle_delta
#	if abs(temp_angle - angle) < rotationdeg:
#		angle = temp_angle
#	else:
#		if angle <= 180:
#			if temp_angle - angle < 180:
#				angle_delta = 1
#			else:
#				angle_delta = -1
#		else:
#			if angle - temp_angle < 180:
#				angle_delta = -1
#			else:
#				angle_delta = 1
#		angle = angle + angle_delta*rotationdeg
#	print(angle)
#	velocity = Vector2(cos(angle/180*PI), sin(angle/180*PI))
#	velocity.normalized()
	velocity = transform.x * speed
	position += velocity * delta
	

func _on_visible_on_screen_notifier_2d_screen_exited():
	print("deleted")
	queue_free()
