class_name Player extends CharacterBody2D


const SPRINT_SPEED_MULTIPLIER : float = 2.0 #Multiplier for the "sprinting" speed
const NORMAL_SPEED : float = 100.00 #Normal movement speed for the camera

var move_speed : float = NORMAL_SPEED #Sets the movement speed to the predefined normal speed

func _physics_process(_delta: float) -> void:
	
	if Input.is_action_pressed("Sprint"):
		move_speed = NORMAL_SPEED * SPRINT_SPEED_MULTIPLIER
	
	var direction : Vector2 = Vector2.ZERO
	
	direction.x = Input.get_action_strength("m_right") - Input.get_action_strength("m_left")
	direction.y = Input.get_action_strength("m_down") - Input.get_action_strength("m_up")
	
	velocity = direction * move_speed
	
	move_and_slide()
	
	move_speed = NORMAL_SPEED
	

func _input(event: InputEvent) -> void:
	
	if event.is_action_pressed("Exit_Game"): #Exits the game once the esc key has been hit
		get_tree().quit()
	
