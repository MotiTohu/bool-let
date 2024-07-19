extends Sprite2D

@onready var player = %Player

func _process(_delta):
	position = player.aim_pos
