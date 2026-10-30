extends CharacterBody2D

@export var tile_map:TileMap

var grid_pos: Vector2i


func _ready() -> void:
	if tile_map:
		grid_pos = tile_map.local_to_map(position)


func move_by_card(offset:Vector2i):
	grid_pos+=offset
	if tile_map:
		position = tile_map.map_to_local(grid_pos)
		
