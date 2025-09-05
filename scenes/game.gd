extends Node2D

@onready var player_left: Node2D = $PlayerLeft
@onready var player_right: Area2D = $PlayerRight

@onready var choose_okay: Button = $ChooseOkay
@onready var toggle_choose: Button = $ToggleChoose

@onready var file_badge: Control = $FileBadge
@onready var enemy_hand: Node2D = $EnemyHand

var downloads_path: String = OS.get_system_dir(OS.SYSTEM_DIR_DOWNLOADS)

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
	
func _list_files(path: String) -> Array:
	var files: Array = []
	var da := DirAccess.open(path)
	if da == null:
		push_error("Cannot open directory: %s" % path)
		return files

	da.list_dir_begin()
	while true:
		var file_name = da.get_next()
		if file_name == "": break
		if da.current_is_dir(): continue
		if file_name.begins_with("."): continue
		files.append(file_name)
	da.list_dir_end()
	return files

func _pick_enemy() -> void:
	var files: PackedStringArray = _list_files(downloads_path)
	if files.is_empty():
		file_badge.set_file("[empty Downloads]")
		return

	var idx: int = randi() % files.size()
	var chosen: String = files[idx]
	file_badge.set_file(chosen)

	var move: int = randi() % EnemyHand.Move.size()
	enemy_hand.set_move(move)
