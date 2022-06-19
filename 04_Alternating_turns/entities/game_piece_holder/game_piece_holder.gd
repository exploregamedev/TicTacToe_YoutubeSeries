extends Node2D
class_name GamePieceHolder


var game_piece_scene: PackedScene = preload("res://entities/game_piece/game_piece.tscn")
var _game_board: GameBoard
# an easy way to get x if we have o and vise versa
var _pieces_toggle = {"x":"o", "o":"x"}
# hold reference to the current game pieces
var _holder_game_pieces = {
	"x": null,
	"o": null
}


func initialize(game_board: GameBoard) -> void:
	_game_board = game_board
	_spawn_game_piece("x")
	_spawn_game_piece("o")


func initialize_player_turn(just_played_piece: GamePiece) -> void:
	_set_pieces_holder_state(just_played_piece)


func get_game_piece(x_or_o: String) -> GamePiece:
	return _holder_game_pieces[x_or_o.to_lower()]


func _set_pieces_holder_state(just_played_piece: GamePiece) -> void:
	_spawn_game_piece(just_played_piece.type, false)
	_activate_piece(_other_piece_type(just_played_piece))


func _activate_piece(piece_type: String) -> void:
	(_holder_game_pieces[piece_type.to_lower()] as GamePiece).active = true


func _other_piece_type(this_piece: GamePiece) -> String:
	return _pieces_toggle[this_piece.type]


func _spawn_game_piece(x_or_o: String, is_active=true) -> void:
	var game_piece: GamePiece = game_piece_scene.instance()
	var connection
	connection = game_piece.connect("game_piece_dropped", _game_board, "_on_game_piece_dropped")
	assert(connection == OK)
	game_piece.position = get_node("%s_PiecePosition" % x_or_o.to_upper()).position
	game_piece.type = x_or_o
	game_piece.active = is_active
	_holder_game_pieces[game_piece.type] = game_piece
	add_child(game_piece)
