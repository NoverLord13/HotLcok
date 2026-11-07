extends Node2D

@onready var grid_layer: TileMapLayer = $Grid_Layer
@onready var hand: Control = $Hand
@onready var player_robot: CharacterBody2D = $Player_Robot
@onready var enemies = [$Enemy_Robot,$Enemy_Robot2]

func _ready() -> void:
	hand.card_played.connect(on_card_played)

func on_card_played(card_data: CardData, card_node: Control):

	var target_pos = player_robot.grid_pos + card_data.card_action
	
	match card_data.card_type:
		CardData.CardType.MOVE:
			if is_cell_walkable(target_pos):
				player_robot.move_by_card(card_data.card_action)
				hand.discard_card(card_data, card_node)
			else:
				print("Проход заблокирован")
		
		CardData.CardType.ATTACK:
			var target_enemy = get_enemey_at(target_pos)
			if target_enemy:
				target_enemy.take_damage(1)
				hand.discard_card(card_data, card_node)
			else:
				print("Никого нету")


func is_cell_walkable(target_pos: Vector2i) -> int:
	for enemy in enemies:
		if enemy and enemy.grid_pos == target_pos:
			return false
	return true

func get_enemey_at(pos: Vector2i) -> Node2D:
	for enemy in enemies:
		if enemy and is_instance_valid(enemy) and enemy.grid_pos == pos:
			return enemy	
	return null


func _on_turn_end_button_pressed() -> void:
	print("Ход завершен")
	hand.on_turn_end()
