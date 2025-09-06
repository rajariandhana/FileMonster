extends Control
class_name FileBadge

@onready var icon: TextureRect = $Icon
@onready var label: Label = $Name

@export var base_dir: String = ""

const ICON_GENERIC := preload("res://graphics/file/icon.png")
const IMAGE_EXTS: Array[String] = ["png", "jpg", "jpeg"]
const ICON_SIZE := Vector2(300, 300)

func _ready() -> void:
	_fix_icon_size()
	
func _fix_icon_size() -> void:
	# Fix the control’s rect so containers don’t stretch it
	icon.custom_minimum_size = ICON_SIZE
	icon.size = ICON_SIZE
	icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	# In containers: do NOT expand; just keep your min-size and center
	icon.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	icon.size_flags_vertical = Control.SIZE_SHRINK_CENTER

	# Let the label take remaining width if they share an HBox/VBox
	label.size_flags_horizontal = Control.SIZE_EXPAND_FILL

func set_file(name: String) -> void:
	label.text = name
	var tex := _maybe_load_image(name)
	icon.texture = tex if tex != null else ICON_GENERIC

func _maybe_load_image(name: String) -> Texture2D:
	var lower := name.to_lower()
	var is_image := false
	for ext in IMAGE_EXTS:
		if lower.ends_with(ext):
			is_image = true
			break
	if not is_image or base_dir == "":
		return null

	var full_path := base_dir.path_join(name)

	var img := Image.new()
	var err := img.load(full_path)
	if err != OK:
		push_warning("Failed to load image: %s (err=%d)" % [full_path, err])
		return null

	return ImageTexture.create_from_image(img)
