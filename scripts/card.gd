extends Area2D
class_name Card

var is_scaled_up : bool
var scale_factor := Vector2(1.3, 1.3)
var original_scale := Vector2.ONE
var bottom_y := 0.0
var activable: bool

@onready var info: Sprite2D = $info

signal nofity_left_hand(card: Card)

func _ready():
	bottom_y = get_bottom_position_y()
	info.visible = false	
	activable = true

func set_activable(value):
	activable = value

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and activable:
		if is_scaled_up:
			unselect()
		else:
			select()
		
func select():
	set_scale_from_bottom(original_scale * scale_factor)
	is_scaled_up = true
	info.visible = true
	emit_signal("nofity_left_hand", self)

func unselect():
	set_scale_from_bottom(original_scale)
	is_scaled_up = false
	info.visible = false

func get_bottom_position_y() -> float:
	# Find the lowest point based on children — in this case, Sprite2D
	var max_y := 0.0
	for child in get_children():
		if child is Sprite2D:
			var sprite_bottom = child.position.y + child.texture.get_size().y * 0.5 * child.scale.y
			max_y = max(max_y, sprite_bottom)
		elif child is CollisionShape2D and child.shape is RectangleShape2D:
			var shape_bottom = child.position.y + child.shape.extents.y
			max_y = max(max_y, shape_bottom)
	return max_y


func set_scale_from_bottom(new_scale: Vector2):
	var current_bottom_global := to_global(Vector2(0, bottom_y))
	scale = new_scale
	var new_bottom_global := to_global(Vector2(0, bottom_y))
	var offset := current_bottom_global - new_bottom_global
	global_position += offset
