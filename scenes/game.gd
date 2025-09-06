extends Node2D

@onready var player_left: Node2D = $PlayerLeft
@onready var player_right: Area2D = $PlayerRight

@onready var choose_okay: Button = $ChooseOkay
@onready var toggle_choose: Button = $ToggleChoose

@onready var file_badge: FileBadge = $FileBadge
@onready var enemy_hand: Node2D = $EnemyHand

@onready var timer: Node = $Timer
#@onready var status: Control = $Status

@onready var button_shoot: TextureButton = $ButtonShoot

@onready var bg_layer: CanvasLayer = $CanvasLayer
@onready var bg_video: VideoStreamPlayer = $CanvasLayer/VideoStreamPlayer
@onready var bg_rect: ColorRect = $CanvasLayer/ColorRect

var downloads_path: String = OS.get_system_dir(OS.SYSTEM_DIR_DOWNLOADS)

func _ready() -> void:
	bg_layer.layer = -1                          # draw behind the game
	bg_video.expand = true                       # fill screen
	bg_video.mouse_filter = Control.MOUSE_FILTER_IGNORE
	bg_video.autoplay = true                     # (optional) start automatically
	if is_instance_valid(bg_rect):
		bg_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE

	file_badge.base_dir = downloads_path
	randomize()
	reset_state()
	
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

func _on_button_shoot_pressed() -> void:
	button_shoot.visible = false;
	#player_left.toggle_activable(false)
	#player_right.toggle_choose(false)
	player_right.deactivate_choose()
	
	var move: int = randi_range(1,3)
	enemy_hand.set_move(move)
	
	process_status()
	timer.start(2.5)

func process_status():
	var win = check_win(player_right.get_move(), enemy_hand.get_move())
	if win == 0:
		#status.text = "TIE"
		pass
		#enemy_hand.yellow()
		#player_right.yellow()
	elif win == 1:
#		damage, delete
		#status.text = "WIN"
		enemy_hand.red()
	else:
		#status.text = "LOSE"
		player_right.red()
	
func check_win(player, enemy):
	#print(str(player)+" "+str(enemy))
	if player==enemy:
		return 0
	elif player==1 and enemy==3 || player==2 and enemy==1 || player==3 && enemy==2:
		return 1
	return -1

func reset_state():
	_pick_enemy()
	#player_left.toggle_activable(true)
	#player_right.toggle_choose(true)
	button_shoot.visible = true
	#status.text="choosing..."
	player_right.activate_choose()
	player_right.set_move(1)
	enemy_hand.set_move(0)
	timer.stop()

func _on_timer_timeout() -> void:
	reset_state()	
