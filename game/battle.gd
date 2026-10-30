extends Node2D

@onready var hand: Control = $Hand
@onready var player_robot: CharacterBody2D = $Player_Robot

func _ready() -> void:
	hand.card_played.connect(on_card_played)


func on_card_played(card_data: CardData):
	if player_robot:
		player_robot.move_by_card(card_data.card_action)
