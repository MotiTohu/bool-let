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


var enemy_hp_bars: Array[ProgressBar] = []
const ENEMY_HP_BAR = preload("res://scenes/UI/enemy_hp_bar.tscn")
@export var MaxEnemyHP :float = 300.0 :
	set(v):
		for i in enemy_hp_bars:
			$EnemyHP.remove_child(i)
		enemy_hp_bars.clear()
		for i in ceilf((v-0.1)/100.0):
			var Bar := ENEMY_HP_BAR.instantiate()
			if i != 0:
				Bar.size.x = 400
				Bar.size.y = 20
				Bar.position.y += 35 + i * 30
			$EnemyHP.add_child(Bar)
			enemy_hp_bars.push_back(Bar)
		MaxEnemyHP = v
		EnemyHP = v
@export var EnemyHP :float = 100.0:
	set(v):
		EnemyHP = v
		if not enemy_hp_bars:
			return 
		for i in ceilf(MaxEnemyHP/100.0):
			if i == 0:
				enemy_hp_bars[i].value = fmod(v,100.1)
			else:
				if i * 100.0 < v:
					enemy_hp_bars[i].value = 100.0
				else:
					enemy_hp_bars[i].value = 0.0
			
			
func _ready() -> void:
	UIControl.on_max_enemy_hp_changed.connect(func(v:float):MaxEnemyHP=v)
	UIControl.on_enemy_hp_changed.connect(func(v:float):EnemyHP=v)
	MaxEnemyHP = UIControl.max_enemy_hp
	EnemyHP = UIControl.max_enemy_hp
	
	UIControl.on_player_hp_changed.connect(func(v:float):HP=v)
	HP = UIControl.player_hp
