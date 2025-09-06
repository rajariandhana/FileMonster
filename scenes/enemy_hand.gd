extends Node2D
class_name EnemyHand

enum Move { DEFL, ROCK, PAPER, SCISSORS }

@onready var art: Sprite2D = $Art

const TEX := {
	Move.DEFL:     preload("res://graphics/enemy_hand/default.png"),
	Move.ROCK:     preload("res://graphics/enemy_hand/rock.png"),
	Move.PAPER:    preload("res://graphics/enemy_hand/paper.png"),
	Move.SCISSORS: preload("res://graphics/enemy_hand/scissors.png"),
}

var current: int = Move.DEFL

func set_move(m: int) -> void:
	current = m
	art.texture = TEX[m]   # <--- here you swap the texture

#func _ready() -> void:
	#set_move(Move.SCISSORS)
