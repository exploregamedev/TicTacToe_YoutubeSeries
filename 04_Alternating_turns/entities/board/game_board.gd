extends Node2D
class_name GameBoard

signal player_placed_game_piece_on_board(game_piece)

var game_tile_scene: PackedScene = preload("res://entities/board/game_tile.tscn")
var _game_piece_over_tile: GameTile
var tiles_matrix: Array = []


# Layout the gameboard tiles grid in the scene
func build_board(board_size: int = 3) -> void:
	var tile_size: int
	for row_number in board_size:
		var this_row = []
		this_row.resize(board_size)
		tiles_matrix.append(this_row)
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
			tiles_matrix[row_number][column_number] = tile
			add_child(tile)


func get_winner():
	return WinDetector.check_win(_dump_state())


func is_full() -> bool:
	var board_state = _dump_state()
	for row in board_state:
		if "" in row:
			return false
	return true


# Connect the area entered/exited signals to functions here so we can
# detect if a game piece is over a given tile. We make the game piece's
# collision shape encompass the entire sprite. The game tile's collision shape
# is a small dot at its center, thus a game piece is never seen to be over more
# then one tile at any given time.
func _spawn_tile() -> GameTile:
	var game_tile: GameTile = game_tile_scene.instance()
	var connection
	connection = game_tile.connect("area_entered", self, "_on_game_tile_area_entered", [game_tile])
	assert(connection == OK)
	connection = game_tile.connect("area_exited", self, "_on_game_tile_area_exited", [game_tile])
	assert(connection == OK)
	return game_tile


func _on_game_tile_area_entered(_game_piece_area: Area2D, tile: GameTile) -> void:
	_game_piece_over_tile = tile


func _on_game_tile_area_exited(_game_piece_area: Area2D, _tile: GameTile) -> void:
	_game_piece_over_tile = null


# If a game piece is dropped over a tile, attach it to that tile
# The signal is attached to the function in TableTop::_spawn_game_piece()
func _on_game_piece_dropped(piece: GamePiece) -> void:
	if _game_piece_over_tile and not _game_piece_over_tile.is_holding_piece:
		_game_piece_over_tile.attach_piece(piece)
		_game_piece_over_tile = null
		print(self)
		emit_signal("player_placed_game_piece_on_board", piece)

# output a simplified matrix of just "x"|"o"|"" values
# this form simplifies the win detection code
func _dump_state() -> Array:
	var state = []
	var board_size = len(tiles_matrix)
	for row_number in board_size:
		var this_row = []
		this_row.resize(board_size)
		state.append(this_row)
		for column_number in board_size:
			var game_tile: GameTile = tiles_matrix[row_number][column_number]
			state[row_number][column_number] = game_tile.held_piece_type
	return state

func _to_string() -> String:
	var ascii_matrix = ""
	for row in _dump_state():
		ascii_matrix += "\n%s" % str(row)
	return ascii_matrix
