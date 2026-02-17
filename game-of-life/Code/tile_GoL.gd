extends TileMapLayer

#******************************************************************************#

## tile_GoL.gd
## Controls the main game logic
## - Cell iteration
## - Iteration speed
## - Player input for mouse clicks

#******************************************************************************#

#Predefines coordinates of alive/dead cells on the tilemap atlas
var alive_cell : Vector2i = Vector2i(1, 0)
var dead_cell : Vector2i = Vector2i(0, 0)

#This variable controls wether or not cells should iterate
var playing : bool = false

#Both the height and width of the "playing" field
@export_category("Map Size")
@export var width : int
@export var height : int


#Variables for the Generational update speed / Timer
var update_speed : float = 0.15 #Seconds per generation
var timer : float = 0.00 #The timer start time

#speed_level defines hoe many times a second the cells should iterate |Different levels have been given to the speed_level_select buttons metadata
var speed_level : int = 1


#Called once when the node enters the scene
func _ready() -> void:
	for x in width:
		for y in height:
			set_cell(Vector2i(x, y), 0, Vector2i(0, 0), 0)
	

#Calculates the iteration speed
func apply_speed() -> void:
	update_speed = 1.0 / speed_level
	


#Runs 60 times per second
func _process(delta: float) -> void:
	if playing:
		timer += delta
		if timer >= update_speed:
			timer = 0.0
			update_cells()


#The main function for the cell iteration
func update_cells() -> void:
	var next_state = []
	
	#Prepares the array in which all cells and their states will be apllyied
	next_state.resize(width)
	for x in width:
		next_state[x] = []
		next_state[x].resize(height)
	
	#"Calculate" the rules on each cell | Does not aplly them on the TileMap
	for x in width:
		for y in height:
			
			var location = Vector2i(x, y)
			var cell = get_cell_atlas_coords(location)
			var neighbors = count_neighbors(location)
			
			if cell == alive_cell:
				if neighbors == 2 or neighbors == 3:
					next_state[x][y] = alive_cell
				else:
					next_state[x][y] = dead_cell
			else:
				if neighbors == 3:
					next_state[x][y] = alive_cell
				else:
					next_state[x][y] = dead_cell
	
	#Aplly the rules on the TileMap
	for x in width:
		for y in height:
			set_cell(Vector2i(x, y), 0, next_state[x][y], 0)
	

#The method to allow all 4 rules to be applied correctly
func count_neighbors(location: Vector2i) -> int:
	var offsets = [
		Vector2i(-1, -1), Vector2i(0, -1), Vector2i(1, -1),
		Vector2i(-1,  0),                  Vector2i(1,  0),
		Vector2i(-1,  1), Vector2i(0,  1), Vector2i(1,  1)
	]
	
	var count = 0
	
	for offset in offsets:
		var new_cell_location = location + offset
	
		#Out of bounds/map check
		if new_cell_location.x < 0 or new_cell_location.y < 0:
			continue
		if new_cell_location.x >= width or new_cell_location.y >= height:
			continue
	
		if get_cell_atlas_coords(new_cell_location) == alive_cell:
			count += 1
	
	return count


#The method called once player input changes a cells status
func toggle_cell(tile_location: Vector2i) -> void:
	var current_cell := get_cell_atlas_coords(tile_location)
	
	if current_cell == alive_cell:
		set_cell(tile_location, 0, Vector2i(0, 0), 0)
	elif current_cell == dead_cell:
		set_cell(tile_location, 0, Vector2i(1, 0), 0)
	


#All input related functions
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Click"):
		if get_viewport().gui_get_hovered_control() != null:
			return
		var mouse_location: Vector2 = get_global_mouse_position()
		var tile_location: Vector2i = local_to_map(mouse_location)
		
		#Out of bounds/map check
		if tile_location.x < 0 or tile_location.y < 0:
			return
		if tile_location.x >= width or tile_location.y >= height:
			return
		
		toggle_cell(tile_location)
	
