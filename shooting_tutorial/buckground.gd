extends Node
var speed = 400

func _ready():
	pass
	
func _process(delta):
	var scroll = Vector2(0,2)
	if Input.is_action_pressed("move_right"):
		scroll.x += 1
	elif Input.is_action_pressed("move_left"):
		scroll.x -= 1
		
	if Input.is_action_pressed("move_up"):
		scroll.y += 1
	elif Input.is_action_pressed("move_down"):
		scroll.y -= 1
		
	#scroll = 200 * delta
	$ParallaxBackground.scroll_offset = scroll
