extends Node2D

export(int) var board_size: int = 3
export(Color) var background_color = Color.black



var game_board_scene: PackedScene = preload("res://entities/board/game_board.tscn")
var game_piece_scene: PackedScene = preload("res://entities/game_piece/game_piece.tscn")
var game_board: GameBoard


func _ready() -> void:
    VisualServer.set_default_clear_color(background_color)
    game_board = game_board_scene.instance()
    game_board.connect("game_piece_placed_on_board", self, "_on_game_piece_placed_on_board")
    game_board.connect("game_piece_placed_off_board", self, "_on_game_piece_placed_off_board")
    game_board.build_board(board_size)
    game_board.position = $BoardPosition.position
    add_child(game_board)
    _spawn_new_game_piece("X")
    _spawn_new_game_piece("O")



func _spawn_new_game_piece(x_or_o: String) -> void:
    var game_piece: GamePiece = game_piece_scene.instance()
    game_piece.connect("game_piece_dropped", game_board, "_on_game_piece_dropped")
    game_piece.position = get_node("%s_PiecePosition" % x_or_o.to_upper()).position
    game_piece.type = x_or_o
    add_child(game_piece)


func _on_game_piece_placed_on_board(game_piece: GamePiece):
    _spawn_new_game_piece(game_piece.type)

func _on_game_piece_placed_off_board(game_piece: GamePiece):
    _return_piece_to_holder(game_piece)

func _return_piece_to_holder(piece: GamePiece):
    piece.position = get_node("%s_PiecePosition" % piece.type.to_upper()).position

func _to_string() -> String:
    return "TableTop"
