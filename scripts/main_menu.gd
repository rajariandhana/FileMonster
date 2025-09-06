extends Node2D

@onready var play_button = $PlayButton
@onready var quit_button = $QuitButton
@onready var hardcore_button = $HardcoreButton

# Preload textures for each button
var play_normal = preload("res://graphics/menu/play.png")
var play_hover = preload("res://graphics/menu/play_hover.png")
var play_pressed = preload("res://graphics/menu/play_pressed.png")

var quit_normal = preload("res://graphics/menu/quit.png")
var quit_hover = preload("res://graphics/menu/quit_hover.png")
var quit_pressed = preload("res://graphics/menu/quit_pressed.png")

var hardcore_normal = preload("res://graphics/menu/hardcore.png")
var hardcore_hover = preload("res://graphics/menu/hardcore_hover.png")
var hardcore_pressed = preload("res://graphics/menu/hardcore_pressed.png")

func _ready():
	# Set textures for each button
	return
	play_button.texture_normal = play_normal
	play_button.texture_hover = play_hover
	play_button.texture_pressed = play_pressed

	quit_button.texture_normal = quit_normal
	quit_button.texture_hover = quit_hover
	quit_button.texture_pressed = quit_pressed

	hardcore_button.texture_normal = hardcore_normal
	hardcore_button.texture_hover = hardcore_hover
	hardcore_button.texture_pressed = hardcore_pressed

	# Connect pressed signals
	play_button.pressed.connect(_on_play_pressed)
	quit_button.pressed.connect(_on_quit_pressed)
	#hardcore_button.pressed.connect(_on_hardcore_pressed)

func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/game.tscn")
	#print("here")
	#get_tree().change_scene("res://scenes/game.tscn")


func _on_quit_pressed():
	get_tree().quit()

#func _on_hardcore_pressed():
	#get_tree().change_scene_to_file("res://scenes/hardcore.tscn")
