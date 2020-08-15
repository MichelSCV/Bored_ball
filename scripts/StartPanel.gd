extends CanvasLayer


# Declare member variables here. Examples:
signal start_game

func show_message(text):
	$Message.text = text
	$Message.show()
	$Timer.start()


func game_over():
	show_message("Game Over")
	yield($Timer, "timeout")
	$Start.show()
	$Message.text = "Bored Bubble" 
	$Message.show()
	
	
func update_points(score):
	$Points.text = str(score)
	



func _on_Timer_timeout():
	$Message.hide()


func _on_Start_pressed():
	$Start.hide()
	emit_signal("start_game")
	
func next_level(level):
	$LevelNumber.text = str(level)
