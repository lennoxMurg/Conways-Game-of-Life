extends TileMapLayer

@export var width : int
@export var height : int

var grid = [] #2D array in which 0 = dead cell and 1 = alive cell


var playing : bool = false

func _ready() -> void:
	
	grid.resize(width)
	for x in width:
		grid[x] = []
		grid[x].resize(height)
		for y in height:
			grid[x][y] = 0
			set_cell(Vector2i(x, y), 0, Vector2i(0, 0), 0)
	
	
	for x in width:
		for y in height:
			set_cell(Vector2i(x, y), 0, Vector2i(0, 0), 0)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Pause"):
		playing = !playing
	
	if event.is_action_pressed("Click"):
		var mouse_pos : Vector2 = get_global_mouse_position()
		var tile_pos : Vector2 = local_to_map(mouse_pos)
		
		if tile_pos.x < 0 or tile_pos.y < 0:
			return
		
		if tile_pos.x >= width or tile_pos.y >= height:
			return
		
		var current = grid[tile_pos.x][tile_pos.y]
		var new_state = 1 - current
		
		grid[tile_pos.x][tile_pos.y] = new_state
		
		if new_state == 1: #Alive
			set_cell(tile_pos, 0, Vector2i(1, 0), 0)
		else: #Dead
			set_cell(tile_pos, 0, Vector2i(0, 0), 0)
	
