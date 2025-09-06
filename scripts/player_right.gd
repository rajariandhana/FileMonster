extends Area2D

@onready var sprite_2d: Sprite2D = $Sprite2D

enum TYPE {
	DEFAULT, ROCK, PAPER, SCISSOR
}

@onready var flash_timer: Timer = $FlashTimer

var choosable:= true
var type
var sprite_path = "res://graphics/player_hand/"
var sprite_end = ".png"
var sprite_name = ["default", "rock", "paper", "scissor"]
var default = sprite_path + sprite_name[0] + sprite_end

func _ready() -> void:
	original_color = sprite_2d.modulate
	flash_timer.autostart = false
	#choosable = false
	#set_move(0)
	
func activate_choose():
	choosable = true
	#set_move(1)
	
func deactivate_choose():
	choosable = false
	#set_move(0)
	
func toggle_choose(value):
	#print(value)
	choosable = value
	if (choosable):
		type = 1
	#else:
		#type = 0
	sprite_2d.texture = load(sprite_path + sprite_name[type] + sprite_end)

func set_move(value):
	type = value
	var path = sprite_path + sprite_name[type] + sprite_end
	sprite_2d.texture = load(sprite_path + sprite_name[type] + sprite_end)
	sprite_2d.texture = load(path)
	
func toggle_type():
	var value=type+1
	if (value == 4):
		value = 1
	set_move(value)

func get_move():
	return type
	
func _input_event(viewport, event, shape_idx) -> void:
	if event is InputEventMouseButton and event.pressed and choosable:
		toggle_type()


var original_color : Color = Color(1, 1, 1)
var red_flash_color : Color = Color(1, 0, 0)  # Red color for damage
var yellow_flash_color : Color = Color(0.8, 0, 0)
var flash_duration : float = 0.2
var flash_count : int = 6
var flashes_left : int = 0
var current_flash_color : Color = Color(1, 1, 1)

func red():
	current_flash_color = red_flash_color
	flashes_left = flash_count
	flash_timer.start(flash_duration)
func yellow():
	current_flash_color = yellow_flash_color
	flashes_left = flash_count
	flash_timer.start(flash_duration)

func _on_flash_timer_timeout():
	if flashes_left > 0:
		sprite_2d.modulate = current_flash_color if flashes_left % 2 == 1 else original_color
		flashes_left -= 1
		flash_timer.start(flash_duration)
	else:
		sprite_2d.modulate = original_color
