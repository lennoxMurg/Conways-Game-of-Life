class_name Hud extends CanvasLayer

##Variable used to toggle HUD visibility
@onready var HUD : Control = $Control

##Variable for the TileMap |Used to pause/unpause and control the update speed
@onready var game := get_node("../TileMapLayer")

##Variables for the two different buttons
@onready var play_pause: TextureButton = $Control/PlayPause

@export_category("Play / Pause")
@export var icon_play:Texture2D
@export var icon_pause:Texture2D

@onready var next_step: TextureButton = $Control/NextStep

##Variables for the speed indicator of the generation update time
@onready var speed_ring_button: Button = $Control/Speed_Ring_Button
@onready var speed_controls: VBoxContainer = $Control/Speed_controls
@onready var speed_display: Label = $Control/Speed_Ring_Button/Speed_Display



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if game.playing:
		play_pause.texture_normal = icon_play
	else:
		play_pause.texture_normal = icon_pause
	


func _on_play_pause_pressed() -> void:
	game.playing = !game.playing
	
	if game.playing:
		play_pause.texture_normal = icon_play
	else:
		play_pause.texture_normal = icon_pause
	


func _on_next_step_pressed() -> void:
	game.update_cells()
	

func _on_speed_ring_button_pressed() -> void:
	speed_controls.visible = !speed_controls.visible
	

func update_speed_display() -> void:
	speed_display.text = str(game.speed_level)
	


func _on_speed_level_pressed(button: Button) -> void:
	var value : int = button.get_meta("speed_level")
	
	game.speed_level = value
	game.apply_speed()
	update_speed_display()
	
	speed_controls.visible = !speed_controls.visible


#All input related Functions
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Hide_Hud"):
		HUD.visible = !HUD.visible
	
	if event.is_action_pressed("Pause"):
		_on_play_pause_pressed()
	
	if event.is_action_pressed("Next_Step"):
		game.update_cells()
	
