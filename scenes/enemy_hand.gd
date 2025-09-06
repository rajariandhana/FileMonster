extends Node2D
class_name EnemyHand

enum Move { DEFL, ROCK, PAPER, SCISSORS }

@onready var art: Sprite2D = $Art
@onready var flash_timer: Timer = $FlashTimer

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

func _ready() -> void:
	set_move(Move.DEFL)
	original_color = art.modulate
	flash_timer.autostart = false
	
func get_move():
	return current


var original_color : Color = Color(1, 1, 1)
var red_flash_color : Color = Color(1, 0, 0)  # Red color for damage
#var white_flash_color : Color = Color(1, 1, 1)
var flash_duration : float = 0.2
var flash_count : int = 6
var flashes_left : int = 0
var current_flash_color : Color = Color(1, 1, 1)

func red():
	print(red)
	current_flash_color = red_flash_color
	flashes_left = flash_count
	_set_flash_color()
	flash_timer.start(flash_duration)

func _set_flash_color():
	var flash_color = current_flash_color if flashes_left % 2 == 1 else original_color
	art.modulate = flash_color
	#animasi.modulate = flash_color
	
func _on_flash_timer_timeout():
	if flashes_left > 0:
		flashes_left -= 1
		_set_flash_color()
		flash_timer.start(flash_duration)
	else:
		# Final reset to original color
		art.modulate = original_color
		#animasi.modulate = original_color
