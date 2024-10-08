extends Node

signal on_cam_move_cahnged(mode:bool)
@export var cam_move : bool = true :
	set(v):
		cam_move = v
		on_cam_move_cahnged.emit(v)
