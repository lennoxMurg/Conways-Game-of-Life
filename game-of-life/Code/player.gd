class_name Player extends Camera2D

#******************************************************************************#

## player.gd
## Controls the exit game logic during gameplay

##NOTE Used to be an actual placeholder player movement before feature was cut

#******************************************************************************#

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Exit_Game"): #Exits the game once the esc key has been hit
		get_tree().quit()
	
