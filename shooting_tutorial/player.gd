extends Area2D
@export var speed = 300
var fire_interval
var screen_size
var velocity
var velocity_delta
var hp = 100
const bullet = preload("res://bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready(): # Replace with function body.
	screen_size = get_viewport_rect().size
	velocity = Vector2.ZERO
	velocity_delta = Vector2.ZERO
	fire_interval = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("move_right"):
		velocity.x = 1
	elif Input.is_action_pressed("move_left"):
		velocity.x = -1
	else :
		velocity.x *= 0.2
	if abs(velocity.x) < 0.1:
			velocity.x = 0
			
	if Input.is_action_pressed("move_down"):
		velocity.y = 1
	elif Input.is_action_pressed("move_up"):
		velocity.y = -1
	else:
		velocity.y *= 0.2
	if abs(velocity.y) < 0.1:
			velocity.y = 0
		
	#print(velocity)
	
	if Input.is_action_pressed("move_shift"):
		velocity_delta = velocity.normalized() * speed*0.5
	else:
		velocity_delta = velocity.normalized() * speed
	
	position += velocity_delta * delta
	position = position.clamp(Vector2.ZERO, screen_size)

	if Input.is_action_pressed("fire"):
		
		if fire_interval<1:
			fire_interval = 6
			var bullet1 = bullet.instantiate()
			bullet1.position = position
			get_parent().add_child(bullet1)
		else:
			fire_interval -=1
	$ProgressBar.value = hp
