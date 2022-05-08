extends "res://addons/gut/test.gd"

var GamePieceHolderScene = preload("res://entities/game_piece_holder/game_piece_holder.tscn")
var GameBoardScene = preload("res://entities/board/game_board.tscn")
var GamePieceScene = preload("res://entities/game_piece/game_piece.tscn")

func test_initialize_both_pieces_active():
	var game_board = autofree(GameBoardScene.instance())
	var game_piece_holder = (autofree(GamePieceHolderScene.instance()) as GamePieceHolder)

	game_piece_holder.initialize(game_board)

	assert_true(game_piece_holder.get_game_piece("x").active)
	assert_true(game_piece_holder.get_game_piece("o").active)

func test_initialize_pieces_state_after_first_move_two_player_mode():
	var game_board = autofree(GameBoardScene.instance())
	var game_piece_holder = (autofree(GamePieceHolderScene.instance()) as GamePieceHolder)
	var just_played_piece_x = (autofree(GamePieceScene.instance()) as GamePiece)

	just_played_piece_x.type = "x"

	game_piece_holder.initialize(game_board)
	game_piece_holder.initialize_player_turn(just_played_piece_x)

	assert_false(game_piece_holder.get_game_piece("x").active, "X piece should be INACTIVE after X turn is over")
	assert_true(game_piece_holder.get_game_piece("o").active, "O piece should be ACTIVE after X turn is over")

	var just_played_piece_o = (autofree(GamePieceScene.instance()) as GamePiece)
	just_played_piece_o.type = "o"
	game_piece_holder.initialize_player_turn(just_played_piece_o)

	assert_true(game_piece_holder.get_game_piece("x").active, "X piece should be ACTIVE after O turn is over")
	assert_false(game_piece_holder.get_game_piece("o").active, "O piece should be INACTIVE after O turn is over")

func test_initialize_pieces_state_after_first_move_single_player_mode():
	var game_board = autofree(GameBoardScene.instance())
	var game_piece_holder = (autofree(GamePieceHolderScene.instance()) as GamePieceHolder)
	var game_piece_x = (autofree(GamePieceScene.instance()) as GamePiece)
	var is_single_player_mode = true

	game_piece_x.type = "x"

	game_piece_holder.initialize(game_board)
	game_piece_holder.initialize_player_turn(game_piece_x, is_single_player_mode)

	assert_true(game_piece_holder.get_game_piece("x").active, "In single player mode, player's X piece should be ACTIVE after player turn is over")
	assert_false(game_piece_holder.get_game_piece("o").active, "In single player mode, O piece should be INACTIVE after player turn is over")
