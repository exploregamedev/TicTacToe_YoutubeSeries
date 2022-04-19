extends Node2D
class_name GameTile

export(int) var tile_size: int = 100

var held_piece_type: String = ""
var row_index
var column_index
var is_holding_piece setget ,_is_holding_piece


func _ready() -> void:
	# Have the background ignore mouse events, else it will interfier
	# with Drag&Drop
	$Background.mouse_filter = Control.MOUSE_FILTER_IGNORE
	$Background.rect_size = Vector2(tile_size, tile_size)


# Take the texture from the game piece and apply it to the tile
# Then destroy the game piece
func attach_piece(piece: GamePiece) -> void:
	$XorO.texture = piece.get_texture()
	held_piece_type = piece.type
	piece.queue_free()


func _is_holding_piece() -> bool:
	return held_piece_type != ""

