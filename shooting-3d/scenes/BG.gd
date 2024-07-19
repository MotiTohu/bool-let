extends Node3D
const BG_LINE := preload("res://scenes/BGLine.tscn")
func _on_timer_timeout()->void:
	var line := BG_LINE.instantiate()
	var pos := Vector2.from_angle(randf_range(0,2*PI)) * randf_range(5,100)
	line.position.x = pos.x
	line.position.y = pos.y
	add_child(line)
