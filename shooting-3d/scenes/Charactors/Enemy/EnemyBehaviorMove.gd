class_name EnemyBehaviorMove extends Resource

@export_category("XY_Mode")
@export_enum("TO","CIRCLE","RANDOM") var move_mode_XY : int
@export var speed_XY : float = 1.0
@export var move_to_XY : Vector2 = Vector2.ZERO
@export var circle_size_XY : float = 5.0

func _init() -> void:
	noise_XY.seed = randi()
	noise_Z.seed = randi()
# code
var delta_sum_XY : float = 0
var noise_XY := FastNoiseLite.new()
func move_XY(delta:float) -> Vector2:
	delta_sum_XY += delta * speed_XY
	
	if move_mode_XY == 0:
		delta_sum_XY = min(delta_sum_XY,1)
		return move_to_XY * delta_sum_XY
	elif move_mode_XY == 1:
		delta_sum_XY = fmod(delta_sum_XY,PI*2)
		return Vector2.from_angle(delta_sum_XY) * circle_size_XY
	else:
		return Vector2(noise_XY.get_noise_1d(delta_sum_XY) ,noise_XY.get_noise_1d(-delta_sum_XY)) * circle_size_XY

@export_category("Z_Mode")
@export_enum("TO","CIRCLE","RANDOM") var move_mode_Z : int
@export var speed_Z : float = 1.0
@export var move_to_Z : float = 0.0
@export var circle_size_Z : float = 1.0

var delta_sum_Z : float = 0
var noise_Z := FastNoiseLite.new()
func move_Z(delta:float) -> float:
	delta_sum_Z += delta * speed_Z
	
	if move_mode_Z == 0:
		delta_sum_Z = min(delta_sum_Z,1)
		return move_to_Z * delta_sum_Z
	elif move_mode_Z == 1:
		delta_sum_Z = fmod(delta_sum_Z,PI*2)
		return sin(delta_sum_Z) * circle_size_Z
	else:
		return noise_Z.get_noise_1d(delta_sum_Z) * circle_size_Z 

func move(delta:float)->Vector3:
	var XY := move_XY(delta)
	var Z := move_Z(delta)
	return Vector3(XY.x,XY.y,Z)
