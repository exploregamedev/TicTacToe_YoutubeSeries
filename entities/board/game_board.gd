extends Node2D
class_name GameBoard

var game_tile_scene: PackedScene = preload("res://entities/board/game_tile.tscn")
var _game_piece_over_tile: GameTile
#signal game_piece_dropped(game_piece)
signal game_piece_placed_on_board(game_piece)
signal game_piece_placed_off_board(game_piece)

var board_matrix: Array = []

func build_board(board_size: int = 3)-> void:
    var tile_size: int
    for row_number in board_size:
        var this_row = []
        this_row.resize(board_size)
        board_matrix.append(this_row)
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

func get_winner():
    return WinDetector.check_win(self.board_matrix)


func _spawn_tile() -> GameTile:
    var game_tile: GameTile = game_tile_scene.instance()
    game_tile.connect("area_entered", self, "_on_game_tile_area_entered", [game_tile])
    game_tile.connect("area_exited", self, "_on_game_tile_area_exited", [game_tile])
    return game_tile


func _on_game_tile_area_entered(_game_piece_area, tile: GameTile):
    if tile.holding_piece():
        return
    _game_piece_over_tile = tile


func _on_game_tile_area_exited(_game_piece_area, tile: GameTile):
    _game_piece_over_tile = null


func _on_game_piece_dropped(piece: GamePiece):
    if _game_piece_over_tile:
        _game_piece_over_tile.attach_piece(piece)
        board_matrix[_game_piece_over_tile.row_index][_game_piece_over_tile.column_index] = piece.type
        _game_piece_over_tile = null
        print(self)
        emit_signal("game_piece_placed_on_board", piece)
    else:
        emit_signal("game_piece_placed_off_board", piece)

func _to_string() -> String:
    var ascii_matrix = ""
    for row in board_matrix:
        ascii_matrix += "\n%s" % str(row)
    return ascii_matrix
