class_name CardData
extends Resource

enum CardType {MOVE,ATTACK}

@export var card_name:= "name"
@export var description:= "description"
@export var card_type: CardType
@export var card_action: Vector2i
@export var card_texture: Texture2D
