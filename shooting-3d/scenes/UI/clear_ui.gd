extends Control
@onready var Score: Label = %clear_score
func show_score(score:int)->void:
	Score.text = str(score)
