extends Control
class_name FileBadge

@onready var icon: TextureRect = $Icon
@onready var label: Label = $Name

const ICON_GENERIC := preload("res://graphics/file/icon.png")

func set_file(name: String) -> void:
	label.text = name
	icon.texture = ICON_GENERIC   # later we’ll add file-type logic
