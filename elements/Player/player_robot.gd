extends CharacterBody2D

@export var grid_layer:TileMapLayer

var grid_pos: Vector2i


func _ready() -> void:
	if grid_layer:
		grid_pos = grid_layer.local_to_map(position)
		position = grid_layer.map_to_local(grid_pos)

func move_by_card(offset:Vector2i):
	grid_pos+=offset
	if grid_layer:
		position = grid_layer.map_to_local(grid_pos)
		
