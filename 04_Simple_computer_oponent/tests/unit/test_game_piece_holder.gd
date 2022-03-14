extends "res://addons/gut/test.gd"

var GamePieceHolder = preload("res://entities/game_piece_holder/game_piece_holder.tscn")
var GameBoard = preload("res://entities/board/game_board.tscn")
var GamePiece = preload("res://entities/game_piece/game_piece.tscn")

func test_initialize_both_pieces_active():
	var game_board = autofree(GameBoard.instance())
	var game_piece_holder = (autofree(GamePieceHolder.instance()) as GamePieceHolder)

	game_piece_holder.initialize(game_board)

	assert_true(game_piece_holder.get_game_piece("x").active)
	assert_true(game_piece_holder.get_game_piece("o").active)

func test_initialize_pieces_state_after_first_move():
	var game_board = autofree(GameBoard.instance())
	var game_piece_holder = (autofree(GamePieceHolder.instance()) as GamePieceHolder)
	var game_piece_x = (autofree(GamePiece.instance()) as GamePiece)

	game_piece_x.type = "x"

	game_piece_holder.initialize(game_board)
	game_piece_holder.turn_complete(game_piece_x)

	assert_false(game_piece_holder.get_game_piece("x").active, "X piece should be INACTIVE after X turn is over")
	assert_true(game_piece_holder.get_game_piece("o").active, "O piece should be ACTIVE after X turn is over")

	var game_piece_o = (autofree(GamePiece.instance()) as GamePiece)
	game_piece_x.type = "o"
	game_piece_holder.turn_complete(game_piece_x)

	assert_true(game_piece_holder.get_game_piece("x").active, "X piece should be ACTIVE after O turn is over")
	assert_false(game_piece_holder.get_game_piece("o").active, "O piece should be INACTIVE after O turn is over")
