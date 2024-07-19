extends Sprite2D

@onready var player = $"../SubViewportContainer/SubViewport/Node3D/Player"

func _process(delta):
	position = player.aim_pos
