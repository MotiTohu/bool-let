@tool
extends Control
class_name UI

@onready var hp_bar: ProgressBar = $HPBar
@export_range(0.0,100.0) var HP :float = 100.0:
	get:
		return HP
	set(v):
		HP = v
		if(hp_bar):
			hp_bar.value = v

@onready var enemy_hp_bar: ProgressBar = $EnemyHPBar
@export_range(0.0,100.0) var EnemyHP :float = 100.0:
	get:
		return EnemyHP
	set(v):
		EnemyHP = v
		if(enemy_hp_bar):
			enemy_hp_bar.value = v
