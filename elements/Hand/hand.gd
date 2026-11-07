extends Control

signal card_played(card_data:CardData, card_node:Control)

@export var card_scene: PackedScene
@export var container: HBoxContainer
@export var starting_deck: Array[Resource] = []
var main_deck: Array[Resource] = []
var discard_deck: Array[Resource] = []
const hand_size = 6


func _ready() -> void:
	reset_decks()
	draw_start_hand()


func reset_decks():
	main_deck = starting_deck.duplicate()
	main_deck.shuffle()
	discard_deck.clear()


func draw_start_hand():
	clear_hand()
	for i in range(hand_size):
		draw_card()


func draw_card():
	if main_deck.is_empty():
		if discard_deck.is_empty():
			print("Карт в двух колодах нет")
			return
		main_deck=discard_deck.duplicate()
		main_deck.shuffle()
		discard_deck.clear()
		print("Колода дополнена из колоды сброса")
	var card_data = main_deck.pop_front()
	spawn_card(card_data)


func spawn_card(card_data: Resource):
	if not card_scene:
		print("Ошибка: Не назначена сцена CardUI в инспекторе")
		return

	var new_card = card_scene.instantiate()
	new_card.data = card_data
	new_card.card_clicked.connect(on_card_clicked.bind(new_card))
	container.add_child(new_card)
	
func on_card_clicked(card_data: CardData, card_node: Control):
	print("Сыграна карта: ", card_data.card_name)
	card_played.emit(card_data,card_node)

func discard_card(card_data:CardData, card_node: Control):
	if card_node and is_instance_valid(card_node):
		discard_deck.append(card_data)
		card_node.queue_free()

func clear_hand():
	for child in container.get_children():
		child.queue_free()

func on_turn_end():
	for child in container.get_children():
		discard_deck.append(child.data)
		child.queue_free()
	for i in range(hand_size):
		draw_card()
