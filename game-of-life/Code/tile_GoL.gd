extends TileMapLayer

var alive : Vector2i = Vector2i(1, 0)
var dead : Vector2i = Vector2i(0, 0)

var playing : bool = false

@export_category("Map Size")
@export var width : int
@export var height : int


func _ready() -> void:
	for x in width:
		for y in height:
			set_cell(Vector2i(x, y), 0, Vector2i(0, 0), 0)
	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Pause"):
		playing = !playing

	if event.is_action_pressed("Click"):
		var mouse_pos: Vector2 = get_global_mouse_position()
		var tile_pos: Vector2i = local_to_map(mouse_pos)
		
		# Out of bounds check
		if tile_pos.x < 0 or tile_pos.y < 0:
			return
		if tile_pos.x >= width or tile_pos.y >= height:
			return
		
		toggle_cell(tile_pos)
	


func toggle_cell(tile_pos: Vector2i) -> void:
	var current_cell := get_cell_atlas_coords(tile_pos)
	
	if current_cell == alive:
		set_cell(tile_pos, 0, Vector2i(0, 0), 0)
	elif current_cell == dead:
		set_cell(tile_pos, 0, Vector2i(1, 0), 0)
	
