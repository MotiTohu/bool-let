extends Sprite2D

@onready var player = %Player

func _process(_delta:float)->void:position = player.aim_pos
