extends Node3D

@export var AMOUNT :int = 3

const BG_LINE := preload("res://scenes/Graphics/BGLine.tscn")
func _on_timer_timeout()->void:
	for i in AMOUNT:
		var line := BG_LINE.instantiate()
		var pos := Vector2.from_angle(randf_range(0,2*PI)) * randf_range(8,100)
		line.position.x = pos.x
		line.position.y = pos.y
		add_child(line)
