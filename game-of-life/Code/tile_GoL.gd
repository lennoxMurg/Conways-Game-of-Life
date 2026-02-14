extends TileMapLayer

@onready var cell_out_line: TileMapLayer = $CellOutLine #Gets the outline node as a variable


const TILE_SIZE : int = 16

@export var width : int
@export var height : int



func _ready() -> void:
	for x in width:
		for y in height:
			set_cell(Vector2i(x, y), 0, Vector2i(0, 0), 0)
