extends Node2D
class_name GameBoard

signal game_piece_placed_on_board(game_piece)

var game_tile_scene: PackedScene = preload("res://entities/board/game_tile.tscn")
var _game_piece_over_tile: GameTile
var board_matrix: Array = []


func build_board(board_size: int = 3)-> void:
	var tile_size: int
	for row_number in board_size:
		var this_row = []
		this_row.resize(board_size)
		for column_number in board_size:
			var tile: GameTile = _spawn_tile()
			tile_size = tile.tile_size
			var x_offset = (10 + tile_size) * column_number
			var y_offset = (10 + tile_size) * row_number
			var tile_position = Vector2(
				position.x + x_offset,
				position.y + y_offset
			)
			tile.position = tile_position
			tile.row_index = row_number
			tile.column_index = column_number
			add_child(tile)


func _spawn_tile() -> GameTile:
	var game_tile: GameTile = game_tile_scene.instance()
	var connection
	connection = game_tile.connect("area_entered", self, "_on_game_tile_area_entered", [game_tile])
	assert(connection == OK)
	connection = game_tile.connect("area_exited", self, "_on_game_tile_area_exited", [game_tile])
	assert(connection == OK)
	return game_tile


func _on_game_tile_area_entered(_game_piece_area, tile: GameTile):
	if tile.holding_piece():
		return
	_game_piece_over_tile = tile


func _on_game_tile_area_exited(_game_piece_area, _tile: GameTile):
	_game_piece_over_tile = null


func _on_game_piece_dropped(piece: GamePiece):
	if _game_piece_over_tile:
		_game_piece_over_tile.attach_piece(piece)
		_game_piece_over_tile = null
		emit_signal("game_piece_placed_on_board", piece)
