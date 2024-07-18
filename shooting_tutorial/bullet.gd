extends Area2D
@export var speed = 800

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position.y -= speed


func _on_visible_on_screen_enabler_2d_screen_exited():
	print("deleted")
	queue_free()
