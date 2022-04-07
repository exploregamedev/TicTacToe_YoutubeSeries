extends Node
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


func other_piece_type(game_piece: GamePiece) -> String:
	return _pieces_toggle[game_piece.type]


func initialize_player_turn(just_played_piece: GamePiece, in_single_player_mode: bool) -> void:
	_set_pieces_holder_state(just_played_piece, in_single_player_mode)


func _set_pieces_holder_state(just_played_piece: GamePiece, in_single_player_mode: bool) -> void:
	if in_single_player_mode:
		_spawn_game_piece(just_played_piece.type)
		# deactivate the computer's piece so player connot drag
		_set_piece_state(other_piece_type(just_played_piece), false)
	else:
		# spawn a replacement piece in the inacative state
		_spawn_game_piece(just_played_piece.type, false)
		# activate player 2' piece
		_set_piece_state(other_piece_type(just_played_piece), true)


func _set_piece_state(piece_type: String, is_active: bool) -> void:
	(_holder_game_pieces[piece_type.to_lower()] as GamePiece).active = is_active


func get_game_piece(x_or_o: String) -> GamePiece:
	return _holder_game_pieces[x_or_o.to_lower()]


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


func _return_piece_to_holder(piece: GamePiece) -> void:
	piece.position = get_node("%s_PiecePosition" % piece.type.to_upper()).position
