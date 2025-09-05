extends Node2D

@onready var player_left: Node2D = $PlayerLeft
@onready var player_right: Area2D = $PlayerRight

@onready var choose_okay: Button = $ChooseOkay
@onready var toggle_choose: Button = $ToggleChoose

@onready var file_badge: Control = $FileBadge
@onready var enemy_hand: Node2D = $EnemyHand

func _ready() -> void:
	toggle_choose.visible = true	
	choose_okay.visible = false
	randomize()
	_pick_enemy()

func _on_toggle_choose_pressed() -> void:
	toggle_choose.visible = false
	choose_okay.visible = true
	player_left.toggle_activable(true)
	player_right.toggle_choose(true)
	
func _on_choose_okay_pressed() -> void:
	choose_okay.visible = false;
	player_left.toggle_activable(false)
	player_right.toggle_choose(false)
	
	var new_move = randi() % enemy_hand.Move.size()
	enemy_hand.set_move(new_move)
	
func _pick_enemy():
	var fake_file = "test.txt"
	#var enemy_move = randi() % 3
	file_badge.set_file(fake_file)
	#enemy_hand.set_move(enemy_move)
