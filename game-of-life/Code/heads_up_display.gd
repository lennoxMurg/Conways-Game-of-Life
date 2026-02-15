class_name Hud extends CanvasLayer

#Variable for the TileMap |Used to pause/unpause and control the update speed
@onready var game := get_node("../TileMapLayer")

#Variables for the two different buttons
@onready var play_pause: TextureButton = $Control/PlayPause
@export var icon_play:Texture2D
@export var icon_pause:Texture2D

@onready var next_step: TextureButton = $Control/NextStep

#Variables for the speed indicator of the generation update time
@onready var speed_number: Label = $Control/SpeedNumber
@onready var speed_ring: TextureRect = $Control/SpeedRing



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


func _on_play_pause_pressed() -> void:
	game.toggle_play_pause()
	
	if game.playing:
		play_pause.texture_normal = icon_pause
	else:
		play_pause.texture_normal = icon_play
		


func _on_next_step_pressed() -> void:
	pass # Replace with function body.
	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Pause"):
		game.toggle_play_pause()
	
