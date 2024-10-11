extends Node

signal on_max_enemy_hp_changed(hp:float)
var max_enemy_hp: float:
	set(v):
		max_enemy_hp = v
		on_max_enemy_hp_changed.emit(v)
signal on_enemy_hp_changed(hp:float)
var enemy_hp : float:
	set(v):
		enemy_hp = v
		on_enemy_hp_changed.emit(v)


signal on_max_player_hp_changed(hp:float)
var max_player_hp: float:
	set(v):
		max_player_hp = v
		on_max_player_hp_changed.emit(v)
signal on_player_hp_changed(hp:float)
var player_hp : float:
	set(v):
		player_hp = v
		on_player_hp_changed.emit(v)

enum GAME_STATUS {
	RESET,
	START,
	CLEAR,
	FAILURE
}
var game_status : GAME_STATUS = 0
signal reset_game
signal start_game
signal clear_game
signal failre_game

func _ready() -> void:
	reset_game.connect(func():
		moveable_enxt_ui = false
		game_status=GAME_STATUS.RESET
		await get_tree().create_timer(5).timeout
		moveable_enxt_ui = true
		)
	start_game.connect(func():
		game_status=GAME_STATUS.START
		SCORE = 60 * 3 * 100
		remaining_time = 60 * 3
		)
	clear_game.connect(func():
		moveable_enxt_ui = false
		game_status=GAME_STATUS.CLEAR
		await get_tree().create_timer(5).timeout
		moveable_enxt_ui = true
		)
	failre_game.connect(func():
		moveable_enxt_ui = false
		game_status=GAME_STATUS.FAILURE
		await get_tree().create_timer(5).timeout
		moveable_enxt_ui = true
		)
	var timer := get_tree().create_timer(0.1)
	timer.timeout.connect(func():reset_game.emit())
	
@export var SCORE := 0.0
@export var remaining_time := 0.0
var moveable_enxt_ui := true
func is_pressded_any_button() -> bool:
	return Input.is_action_just_pressed("shoot") or Input.is_action_just_pressed("change_shoot_mode") or Input.is_action_just_pressed("back") or Input.is_action_just_pressed("front")
func _process(delta: float) -> void:
	if moveable_enxt_ui and game_status == GAME_STATUS.RESET and is_pressded_any_button():
		start_game.emit()
	if moveable_enxt_ui and (game_status == GAME_STATUS.FAILURE or game_status == GAME_STATUS.CLEAR) and is_pressded_any_button():
		reset_game.emit()
	if game_status == GAME_STATUS.START:
		SCORE -= delta * 100
		remaining_time -= delta 
