extends CanvasLayer

signal restart_game
signal quit_game

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_hud_final_score(value):
	$GameOverPanel/ScoreLabel.text = str(value)

func _on_restart_button_pressed():
	emit_signal("restart_game")

func _on_quit_button_pressed():
	emit_signal("quit_game")
