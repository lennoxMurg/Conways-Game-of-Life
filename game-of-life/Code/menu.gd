extends Control

#******************************************************************************#

## menu.gd
## Controls all main menu logic
## - Start game button
## - Quit game button

#******************************************************************************#

@onready var menu_player: AnimationPlayer = $MenuPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	menu_player.play("fade_in")

func _on_quit_btn_pressed() -> void:
	get_tree().quit()

func _on_start_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/LVL/main.tscn")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Exit_Game"):
		get_tree().quit()
	
