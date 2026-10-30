class_name GameCardUI
extends Control

signal card_clicked(card_data:CardData)

@export var data: CardData

@onready var name_label = $name_label
@onready var card_texture = $texture

func _ready():
	update_card_display()
	
func update_card_display():
	if data:
		name_label.text = data.card_name
		if data.card_texture:
			card_texture.texture = data.card_texture
			
func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		card_clicked.emit(data)
