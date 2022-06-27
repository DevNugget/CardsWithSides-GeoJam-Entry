extends Node


# Card indices
# 0 = Axe Card
signal turn_change
var score: int = 0
var current_boss
var global_current_hand=[]
var deck: Array = []
var player_turn = true
var player_health: int = 4
const AXE_CARD = preload("res://Scenes/AxeCard.tscn")
const HP_CARD = preload("res://Scenes/HealthCard.tscn")
const TOXIC_CARD = preload("res://Scenes/ToxinCard.tscn")
const KNIGHT_CARD = preload("res://Scenes/KnightCard.tscn")
const FAIRY_CARD = preload("res://Scenes/FairyCard.tscn")
const DRAW_DRAW_CARD = preload("res://Scenes/DrawCardsCard.tscn")

func _ready():
	randomize()
	generate_random_deck()
	print(deck)


func generate_random_deck():
	randomize()
	for i in range(0, 36):
		var card_index: int = rand_range(0,13)
		print(card_index)
		deck.append(card_index)


func add_new_cards():
	randomize()
	for i in range(0, 6):
		var card_index: int = rand_range(0,13)
		print(card_index)
		deck.append(card_index)
