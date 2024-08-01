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
