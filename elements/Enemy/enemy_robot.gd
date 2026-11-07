extends CharacterBody2D

@export var grid_layer:TileMapLayer
@export var max_health: int = 3
var current_health: int
var grid_pos: Vector2i


func _ready() -> void:
	current_health = max_health
	if grid_layer:
		grid_pos = grid_layer.local_to_map(position)
		position = grid_layer.map_to_local(grid_pos)

func take_damage(ammount: int):
	current_health -= ammount
	print("Враг получил ", ammount, " урона, осталось ", current_health)
	if current_health<=0:
		die()

func die():
	print("Враг умер")
	queue_free()
