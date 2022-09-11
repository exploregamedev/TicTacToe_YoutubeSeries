extends Area2D
class_name GamePiece

var _dragging: bool = false
var type: String setget set_type
var active: bool = true setget _set_active

signal game_piece_dropped(piece)

func _ready() -> void:
	# Need to be above game board (at z=0)
	z_index = 1


# This is part of the implementation of Drag&Drop for a Node2D
# On each frame if _dragging is true this piece's position is set to
# that of the mouse.
func _process(_delta: float) -> void:
	# If the piece is in the inactive state, ignore the input
	if not active:
		return
	if _dragging:
		_attach_to_mouse()


func get_texture() -> Texture:
	return $Sprite.texture


func set_type(x_or_o: String) -> void:
	type = x_or_o.to_lower()
	$Sprite.texture = load("res://assets/sprites/game_piece_%s.png" % type.to_lower())


func _set_active(is_active: bool) -> void:
	active = is_active
	if is_active:
		$Sprite.modulate.a = 1.0
	else:
		$Sprite.modulate.a = 0.5


func _attach_to_mouse() -> void:
	global_position = get_global_mouse_position()


# Here as part of the Drag&Drop implementation, The input_event siganl of our
# CollisionShape2D is mapped to this function.  Thus in the case where the mouse pointer
# is over our game pieces, we can react to the click or release of the right mouse button
func _on_GamePiece_input_event(_viewport: Node, _event: InputEvent, _shape_idx: int) -> void:
	# If the piece is in the inactive state, ignore the input
	if not active:
		return
	# Mouse is over the game piece and left click was made
	if Input.is_action_just_pressed("click"):
		_dragging = true
		$Sprite.scale.x = .8
		$Sprite.scale.y = .8
	# The game piece is being dropped
	elif Input.is_action_just_released("click"):
		_dragging = false
		$Sprite.scale.x = 1
		$Sprite.scale.y = 1
		emit_signal("game_piece_dropped", self)


func _to_string() -> String:
	return "GamePiece[%s]" % type.to_upper()
