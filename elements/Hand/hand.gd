extends Control

signal card_played(card_data:CardData)

@export var card_scene: PackedScene
@export var container: HBoxContainer
@export var starting_deck: Array[Resource] =[]
const hand_size = 6


func _ready() -> void:
	deal_start_hand()


func deal_start_hand():
	for child in container.get_children():
		child.queue_free()
	
	var spawn_deck = starting_deck.slice(0, hand_size)

	for card_data in spawn_deck:
		spawn_card(card_data)


func spawn_card(card_data: Resource):
	if not card_scene:
		print("Ошибка: Не назначена сцена CardUI в инспекторе!")
		return

	var new_card = card_scene.instantiate()
	new_card.data = card_data
	new_card.card_clicked.connect(on_card_clicked.bind(new_card))
	container.add_child(new_card)
	
func on_card_clicked(card_data: CardData, card_node: Control):
	print("Сыграна карта: ", card_data.card_name)
	card_node.queue_free()
	card_played.emit(card_data)
		
