extends Area2D
@export var speed = 20
var velocity  = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity = transform.x * speed
	position += velocity * delta


func _on_timer_timeout():
	queue_free()
