extends Node2D

@onready var player_right: Area2D = $PlayerRight

@onready var choose_okay: Button = $ChooseOkay
@onready var toggle_choose: Button = $ToggleChoose

func _ready() -> void:
	toggle_choose.visible = true	
	choose_okay.visible = false

func _on_toggle_choose_pressed() -> void:
	toggle_choose.visible = false
	choose_okay.visible = true
	player_right.toggle_choose(true)
	
func _on_choose_okay_pressed() -> void:
	choose_okay.visible = false;
	player_right.toggle_choose(false)
