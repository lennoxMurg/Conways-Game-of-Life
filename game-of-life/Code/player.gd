class_name Player extends CharacterBody2D

var move_speed : float = 75.0


func _physics_process(_delta: float) -> void:
	var direction : Vector2 = Vector2.ZERO
	
	direction.x = Input.get_action_strength("m_right") - Input.get_action_strength("m_left")
	direction.y = Input.get_action_strength("m_down") - Input.get_action_strength("m_up")
	
	velocity = direction * move_speed
	
	move_and_slide()
