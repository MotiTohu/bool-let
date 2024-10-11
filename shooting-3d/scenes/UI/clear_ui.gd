extends Control
@onready var Score: Label = %Score
func show_score(score:int)->void:
	Score.text = str(score)
