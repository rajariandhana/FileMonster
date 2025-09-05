extends Area2D

@onready var sprite_2d: Sprite2D = $Sprite2D

enum TYPE {
	ROCK, PAPER, SCISSOR
}

var choosable: bool
var type
var sprite_path = "res://graphics/player_hand/"
var sprite_end = ".png"
var sprite_name = ["default", "rock", "paper", "scissor"]
var default = sprite_path + sprite_name[0] + sprite_end

func _ready() -> void:
	choosable = false
	type = 0
	sprite_2d.texture = load(default)

func toggle_choose(value):
	print(value)
	choosable = value
	if (choosable):
		type = 1
	else:
		type = 0
	sprite_2d.texture = load(sprite_path + sprite_name[type] + sprite_end)
	
func toggle_type():
	type+=1
	if (type == 4):
		type = 1
	var path = sprite_path + sprite_name[type] + sprite_end
	#print(path)
	sprite_2d.texture = load(path)
	
func _input_event(viewport, event, shape_idx) -> void:
	if event is InputEventMouseButton and event.pressed and choosable:
		toggle_type()
