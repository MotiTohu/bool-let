extends Area2D
@export var speed = 100
@export var rotationdeg = 20
@export var viewangle = 0.25*PI
var angle:float
var velocity:Vector2
@onready var tween
@onready var player := $"/root/Main/player"
var lastangle = 180
var countdown = 480


# Called when the node enters the scene tree for the first time.
func _ready():
	rotation = PI/2.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if isrockon():
		lookatp()
	velocity = transform.x * speed
	position += velocity * delta
	countdown -= 1
	if countdown == 0:
		queue_free()
	
func lookatp():
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
	
func isrockon():
	if seeingrad() <= viewangle:
		return(true)
	else:
		return(false)
	
func seeingrad():
	var angle = global_position.angle_to_point(player.global_position)
	var d = angle - rotation
	d -= floor(d / 2*PI) * 2*PI
	if d > PI:
		d -= 2*PI
	d = fmod(d,PI*2)
	print(d)
	return d

func _on_visible_on_screen_notifier_2d_screen_exited():
	#print("deleted")
	queue_free()
