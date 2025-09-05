extends Node2D

@onready var cards: Node2D = $cards

var choosable: bool

func _ready() -> void:
	choosable = false
	print("here")
	for card in cards.get_children():
		if card is Card:
			card.connect("nofity_left_hand", self.select_card)
	toggle_activable(false)
			
func toggle_activable(value):
	for card in cards.get_children():
		if card is Card:
			card.set_activable(value)

func select_card(selected: Card):
	print("here")
	print(selected)
	for card in cards.get_children():
		if card is Card:
			if card != selected:
				card.unselect()

func _process(delta: float) -> void:
	pass
