extends CanvasLayer

signal final_score

var score = 0
func _on_main_reset_score():
	score = 0
	$ScorePanel/Score.text = str(score)

func _process(delta):
	pass

func _on_main_food_eaten(new_value):
	update_score(new_value)

func update_score(new_value):
	score += new_value
	$ScorePanel/Score.text = str(score)


func _on_main_game_over():
	emit_signal("final_score", score)
