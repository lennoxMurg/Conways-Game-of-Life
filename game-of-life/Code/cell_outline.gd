extends TileMapLayer

@onready var cell_map: TileMapLayer = $".." #The main Tile layer

var outline_source_id: int = 1 #Atlas source ID for the OutLine layer
var outline_atlas_coords: Vector2i = Vector2i(0, 0) #Coordinates of the Highlight on the outline layer atlas map

func _process(_delta: float) -> void:
	
	# 1. Get mouse position on the screen
	var mouse_pos: Vector2 = get_global_mouse_position()
	
	# 2. set the tile position to the current mouse position
	var tile_pos: Vector2i = local_to_map(mouse_pos)
	
	# 3. Check if tile is outside of drawn tiles or off screen
	if tile_pos.x < 0 or tile_pos.y < 0:
		clear()
		return
	
	if tile_pos.x >= cell_map.width or tile_pos.y >= cell_map.height:
		clear()
		return
	
	# 4. Clear the last created highlight layer (remove the outLine from cell)
	clear()
	
	# 5. Place new outline on the mouse cursor
	set_cell(tile_pos, outline_source_id, outline_atlas_coords)
	
